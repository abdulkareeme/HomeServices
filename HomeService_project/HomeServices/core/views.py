from rest_framework.decorators import api_view 
from rest_framework.response import Response
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.auth import AuthToken
from .serializers import RegisterSerializer, UserConfirmEmailSerializer , NormalUserSerializer , ListUsersSerializer
from rest_framework.views import APIView
from django.shortcuts import render
from drf_spectacular.utils import extend_schema
from rest_framework import status , generics
from .models import Balance 
from .spectacular_serializers import LoginSpectacular
from .models import NormalUser ,User
from services.serializers import Area,AreaSerializer
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
    
    if user.photo :
        photo = user.photo.url
    else :
        photo = None
    if user.normal_user.average_fast_answer :
        average_fast_answer = user.normal_user.average_fast_answer
    else :
        average_fast_answer = None
    return Response({
        'user_info': {
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name':user.first_name,
            'last_name':user.last_name,
            'mode':user.mode,
            'photo':photo,
            'birth_date':user.birth_date,
            'join_date' : user.date_joined,
            'gender':user.gender,
            'bio':user.normal_user.bio,
            'average_fast_answer' : average_fast_answer
        },
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
        if not user.photo:
            photo  =None
        else : 
            photo = user.photo.url
        return Response(
        {
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name':user.first_name,
            'last_name':user.last_name,
            'mode':user.mode,
            'photo':photo,
            'birth_date':user.birth_date,
            'join_date' : user.date_joined,
            'gender':user.gender,
            'bio':user.normal_user.bio,
        } , status=status.HTTP_200_OK
    )


        