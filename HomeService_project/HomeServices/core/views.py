from rest_framework.decorators import api_view 
from rest_framework.response import Response
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.auth import AuthToken
from .serializers import RegisterSerializer, UserConfirmEmailSerializer , NormalUserSerializer , ListUsersSerializer , PasswordResetSerializer ,UpdateNormalUser
from rest_framework.views import APIView
from django.shortcuts import render
from drf_spectacular.utils import extend_schema
from rest_framework import status , generics ,permissions
from .models import Balance 
from .spectacular_serializers import LoginSpectacular
from .models import NormalUser ,User
from services.serializers import Area,AreaSerializer
from django.contrib.auth.hashers import make_password
from django.utils import timezone
from datetime import timedelta

def get_user_info(user):
    if not user.photo:
            photo  =None
    else : 
        photo = user.photo.url

    if user.normal_user.average_fast_answer :
        average_fast_answer = user.normal_user.average_fast_answer
    else :
        average_fast_answer = None

    clients_number =0
    for service in  user.normal_user.home_services_seller.all() :
        clients_number  += service.home_service.count()
    delta = average_fast_answer
    if delta is not None :
        hours, remainder = divmod(delta.seconds, 3600)
        minutes, seconds = divmod(remainder, 60)
        time_string = f"{hours:02} hours , {minutes:02} minutes"

        days_string = f"{delta.days} days , " if delta.days else ""
        average_fast_answer = f"{days_string}{time_string}"

    return {
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'first_name':user.first_name,
        'last_name':user.last_name,
        'mode':user.mode,
        'photo':photo,
        'birth_date':user.birth_date,
        'date_joined' : user.date_joined,
        'gender':user.gender,
        'bio':user.normal_user.bio,
        'clients_number' : clients_number ,
        'services_number' : user.normal_user.home_services_seller.count() ,
        'average_fast_answer' : average_fast_answer,
    }

@extend_schema(
    request=AuthTokenSerializer,
    responses={200:LoginSpectacular , 400:None}
)
@api_view(['POST'])
def login_api(request):
    if not 'username' in request.data and  'email' in request.data:
        try :   
            username = User.objects.get(email = request.data['email'])
        except User.DoesNotExist :
            return Response({"email":["Email does not exist"]} , status=status.HTTP_400_BAD_REQUEST)
        request.data['username']=username.username
        if not username.is_active :
            return Response({"email":"Email must be confirmed"})
    elif 'username' in request.data :
        try :
            current_user= User.objects.get(username = request.data['username'])
        except User.DoesNotExist :
            return Response({"username":"Username does not exist"})
        if not current_user.is_active :
            return Response({"email":"Email must be confirmed"})

    serializer = AuthTokenSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']
    _, token = AuthToken.objects.create(user)
    
    return Response({
        'user_info': get_user_info(user),
        'token': {token}
    })


class RegisterUser(APIView):

    @extend_schema(
        responses={200:AreaSerializer(many=True) },
        description="list of area",
        
    )
    def get(self , request):
        serializer = AreaSerializer(Area.objects.all() , many=True)
        return Response(serializer.data , status=status.HTTP_200_OK)
    @extend_schema(
    request=RegisterSerializer,
    responses={201:None},
    )
    def post(self , request):
        serializer = RegisterSerializer(
        data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        normal_user = NormalUserSerializer(data = request.data)
        normal_user.is_valid(raise_exception=True)
        user = serializer.save()
        normal_user = normal_user.save(user=user)
        Balance.objects.create(user=normal_user)
        # _, token = AuthToken.objects.create(user)
        return Response({'detail': 'account registered please confirm your email.'} , status=status.HTTP_201_CREATED)

class UserConfirmEmailView(APIView):
    serializer_class = UserConfirmEmailSerializer

    def get(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=kwargs)
        if not serializer.is_valid():
            return render(request, 'core/error_confirming.html')
        return render(request, 'core/confirmed.html')

class ListUsers(APIView):
    @extend_schema(
            responses={200:ListUsersSerializer}
    )
    def get(self, request):
        queryset = NormalUser.objects.all()
        data= []
        for user in queryset :
            result=dict()
            result['username']= user.user.username
            result['first_name'] = user.user.first_name
            result['last_name']=user.user.last_name
            result['photo']=user.user.photo
            result['categories']= []
            if user.home_services_seller:
                for home_service in user.home_services_seller.all() :
                    if home_service.categories :
                        result['categories'].append(home_service.categories)
            
            data.append(result)
        print(data)
        serializer = ListUsersSerializer(data=data , many=True)
        serializer.is_valid(raise_exception=False)
        return Response(serializer.data , status=status.HTTP_200_OK)
    
class RetrieveUser(APIView):
    @extend_schema(
    responses={200:LoginSpectacular , 404:None}
    )
    def get(self ,request , username):
        try :
            user = User.objects.get(username=username)
        except User.DoesNotExist :
            return Response('Error 404 Not Found' , status=status.HTTP_404_NOT_FOUND)
        
        if user.is_superuser : 
            return Response('Error 404 Not Found' , status=status.HTTP_404_NOT_FOUND)
        
        return Response( get_user_info(user) , status=status.HTTP_200_OK)

@extend_schema(
    request=PasswordResetSerializer,
    responses={200 : None , 400 : None , 401 : None}
)
class PasswordResetAPIView(APIView):
    serializer_class = PasswordResetSerializer
    permission_classes = [permissions.IsAuthenticated]
    def post(self, request):
        serializer = self.serializer_class(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = request.user
        user.password = make_password(serializer.validated_data['new_password'])
        user.save()
        return Response({'message': 'Password updated successfully.'}, status=status.HTTP_200_OK)
    
class UserConfirmMessage(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def post(self , request):
        if request.user.is_active :
            return Response({'detail':"Email already verified"}, status=status.HTTP_200_OK)
        
        if request.user.next_confirm_try is not None and request.user.next_confirm_try <= timedelta.now() :
            request.user.confirmation_tries = 3

        if request.user.confirmation_tries == 0 :
            return Response({"detail":f"Try again after{request.user.next_confirm_try - timezone.now()}"} ,status=status.HTTP_400_BAD_REQUEST)
        
        if request.user.confirmation_code != request.POST.get('confirmation_code' , None):
            request.user.is_active = True
            return Response({'detail':"Email verified successfully"} , status=status.HTTP_200_OK)
        else :
            request.user.confirmation_tries -=1
            if request.user.confirmation_tries ==0 :
                request.user.next_confirm_try = timezone.now() + timedelta(hours=24)
                return Response({"detail":f"Try again after{request.user.next_confirm_try - timezone.now()}"} ,status=status.HTTP_400_BAD_REQUEST)
            return Response({"detail":"Wrong code please try again"} , status=status.HTTP_400_BAD_REQUEST)
        #TODO make it serializer

class ResendEmailMessage(APIView):
    permission_classes=[permissions.IsAuthenticated]
    def post(self , request):
        if request.user.is_active :
            return Response({'detail':"Email already verified"}, status=status.HTTP_200_OK)
        #TODO make it serializer


class UpdateUser(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={200:LoginSpectacular}
    )
    def get (self , request):
        user = request.user
        return Response(get_user_info(user) , status=status.HTTP_200_OK)
    @extend_schema(
            request=UpdateNormalUser ,
            responses={200:LoginSpectacular , 400: None}
    )
    def put(self , request):
        user = request.user
        serializer = UpdateNormalUser(data=request.data , instance=user.normal_user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(get_user_info(user) , status=status.HTTP_200_OK)

