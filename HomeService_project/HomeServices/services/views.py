from django.shortcuts import render
from rest_framework.views import APIView
from .models import Category ,Area,HomeService ,Rating  ,GeneralServicesPrice , Beneficiary , Earnings , InputData , InputField , OrderService
from .serializers import AreaSerializer ,CategorySerializer  , RatingSerializer,InputFieldSerializer  , ListOrdersSerializer  ,ListHomeServicesSerializer , RetrieveHomeServices , CreateHomeServiceSerializer ,RetrieveUpdateHomeServiceSerializer,InputFieldSerializerAll ,InputDataSerializer
from rest_framework.response import Response
from rest_framework import status , generics
from rest_framework import permissions
from drf_spectacular.utils import extend_schema
from django.utils import timezone
from django.db.models import Q ,Avg ,F , Sum
from django.db import transaction
from datetime import datetime , timedelta
from .spectacular import ListOrdersSpectacular

class IsOwner(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        return obj.seller == request.user.normal_user

class ListCategories(APIView):
    @extend_schema(
            responses={200:CategorySerializer(many=True)}
    )
    def get(self , request):
        queryset = Category.objects.all()
        serializer = CategorySerializer(data=queryset, many=True)
        serializer.is_valid()
        return Response(serializer.data , status=status.HTTP_200_OK)
    
class MyOrders(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={200:ListOrdersSpectacular}
    )
    def get(self, request):
        queryset= OrderService.objects.filter(client = request.user.normal_user)
        serializer = ListOrdersSerializer(data = queryset , many=True)
        serializer.is_valid()
        i = 0
        for order in queryset :
            serializer.data[i]['client']=order.client.user.username
            serializer.data[i]['home_service']['seller']=order.home_service.seller.user.username
            i+=1
        return Response(serializer.data )
    
class ReceivedOrders(APIView):
    permission_classes=[permissions.IsAuthenticated]
    @extend_schema(
        responses={200:ListOrdersSpectacular , 403:None}
    )
    def get(self , request):
        if request.user.mode == 'client':
            return Response({"detail":"Error 403 Forbidden , you are a buyer you don't receive orders"} , status=status.HTTP_403_FORBIDDEN)
        queryset= OrderService.objects.filter(home_service__seller = request.user.normal_user)
        serializer = ListOrdersSerializer(data = queryset , many=True)
        serializer.is_valid()
        i = 0
        for order in queryset :
            serializer.data[i]['client']=order.client.user.username
            serializer.data[i]['home_service']['seller']=order.home_service.seller.user.username
            i+=1
        return Response(serializer.data )


@extend_schema(
    description="NOTE : When you use this api use :<br> 1 - ( services/list_home_services?username=\{username\} ) to filter \
       the services for this user <br> 2 -  ( services/list_home_services?category=\{category\} ) to filter the services by category\
        3 - else it will be display all services"
       
)
#TODO filter rate order 
class ListHomeServices(generics.ListAPIView):
    queryset = HomeService.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = ListHomeServicesSerializer

    def get_queryset(self):
        if 'username' in self.request.GET:
            return HomeService.objects.filter(seller__user__username = self.request.GET.get('username'))
        if 'category' in self.request.GET :
            return HomeService.objects.filter(category__name = self.request.GET.get('category'))
        return HomeService.objects.all()
    
@extend_schema(
    responses={200:RetrieveHomeServices}
)
class HomeServiceDetail(generics.RetrieveAPIView):
    permission_classes=[permissions.AllowAny]
    serializer_class = RetrieveHomeServices
    queryset = HomeService.objects.all()    

@extend_schema(
    request= CreateHomeServiceSerializer
)
class CreateHomeService(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CreateHomeServiceSerializer

@extend_schema(
    request=RetrieveUpdateHomeServiceSerializer,
    responses={200 : RetrieveUpdateHomeServiceSerializer , 403 : None, 401 : None}
)
class RetrieveUpdateHomeService(generics.RetrieveUpdateAPIView):
    permission_classes =[permissions.IsAuthenticated , IsOwner]
    serializer_class = RetrieveUpdateHomeServiceSerializer
    lookup_url_kwarg = 'home_service_id'
    queryset = HomeService.objects.all()

class ListArea(generics.ListAPIView):
    queryset = Area.objects.all()
    serializer_class = AreaSerializer
    permission_classes = [permissions.AllowAny]

@extend_schema(
    responses= {403 : None , 204:None , 401 : None}
)
class DeleteHomeService(generics.DestroyAPIView):
    queryset = HomeService
    serializer_class = CreateHomeServiceSerializer
    permission_classes = [permissions.IsAuthenticated , IsOwner]
    lookup_url_kwarg = 'home_service_id'

def delete_data(data):
    data.delete()
    return True


class UpdateFormHomeService(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={200 : InputFieldSerializer(many=True)}
    )
    def get(self , request , home_service_id):
        try : 
            home_service = HomeService.objects.get(pk=home_service_id)
        except HomeService.DoesNotExist :
            return Response("404 NOT FOUND", status=status.HTTP_404_NOT_FOUND)
        
        if home_service.seller != request.user.normal_user :
            return Response({"detail" : "403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        queryset= InputField.objects.filter(home_service= home_service , home_service__seller = request.user.normal_user)
        serializer = InputFieldSerializer(data = queryset ,  many=True)
        serializer.is_valid(raise_exception=False)
        return Response(serializer.data , status=status.HTTP_200_OK)
    @extend_schema(
    request=InputFieldSerializer(many=True),
    responses={200:InputFieldSerializer(many=True) , 400 : None , 403 : None , 401 : None}
    )
    def put(self , request , home_service_id):
        try : 
            home_service = HomeService.objects.get(pk=home_service_id)
        except HomeService.DoesNotExist :
            return Response("404 NOT FOUND", status=status.HTTP_404_NOT_FOUND)
        
        if home_service.seller != request.user.normal_user :
            return Response({"detail" : "403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        
        queryset= InputField.objects.filter(home_service = home_service, home_service__seller = request.user.normal_user)
        serializer  = InputFieldSerializer(data= request.data , many=True)
        serializer.is_valid(raise_exception=True)
        if len(serializer.validated_data) < 3 or len(serializer.validated_data) >10 :
            return Response({'detail':["Number of fields must be between 3 and 10"]}, status=status.HTTP_400_BAD_REQUEST)
        
        delete_data(queryset)
        serializer.save(home_service= home_service)
        return Response(serializer.data ,status=status.HTTP_200_OK )


class MakeOrderService(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={404 : None , 200 : InputFieldSerializerAll(many=True) , 401:None}
    )
    def get(self , request , service_id) :
        try :
            home_service = HomeService.objects.get(pk= service_id)
        except HomeService.DoesNotExist :
            return Response({"detail":["404 NOT FOUND"] }, status= status.HTTP_404_NOT_FOUND)
        form  = home_service.field
        serializer = InputFieldSerializerAll(data=form , many=True)
        serializer.is_valid(raise_exception=False)
        return Response(serializer.data , status= status.HTTP_200_OK)

    @extend_schema(
            request=InputDataSerializer(many=True),
            responses={200:None , 400:None , 401:None}
    )
    def post(self , request , service_id):
        try :
            home_service = HomeService.objects.get(pk= service_id)
        except HomeService.DoesNotExist :
            return Response({"detail":["404 NOT FOUND"] }, status= status.HTTP_404_NOT_FOUND)
        
        # if home_service.seller == request.user.normal_user :
        #     return Response({"detail":"You can't order service from yourself"})
        check_sended_orders = OrderService.objects.filter(client = request.user.normal_user , home_service = home_service , status = "Pending" )
        if check_sended_orders.count()>0:
            return Response({"detail":"you have already ordered this service"} , status=status.HTTP_400_BAD_REQUEST)
        serializer = InputDataSerializer(data = request.data , many=True )
        serializer.is_valid(raise_exception=True)

        # validate all fields that belong to this service are exist 
        validated_data = []
        for input_field_1 in home_service.field.all() :
            is_exists = False
            for input_field_2 in serializer.data :
                if input_field_1.id == input_field_2['field'] :
                    is_exists =True
                    validated_data.append(input_field_2)
                    break
            if not is_exists:
                return Response({"detail":f"Error fields are not compatible (you did'nt send field : {input_field_1.id})"} , status= status.HTTP_400_BAD_REQUEST)
        new_order = OrderService.objects.create(client = request.user.normal_user , home_service=home_service )
        new_order.save()
        index = 0
        all_fields = home_service.field.all()
        for input_data in validated_data:
            InputData.objects.create(field = all_fields[index] , content = input_data['content'] , order = new_order).save()
            index+=1

        
        return Response("Success", status=status.HTTP_200_OK)
            