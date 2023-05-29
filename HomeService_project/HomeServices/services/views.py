from django.shortcuts import render
from rest_framework.views import APIView
from .models import Category ,Area,HomeService ,OrderService ,Rating ,PendingBalance ,GeneralServicesPrice , Beneficiary , Earnings
from .serializers import AreaSerializer ,CategorySerializer ,HomeServiceSerializer ,OrderServiceSerializer , RatingSerializer  , PendingBalanceSerializer , ListOrdersSerializer , CreateHomeServiceSerializer ,ListHomeServicesSerializer
from rest_framework.response import Response
from rest_framework import status , generics
from rest_framework import permissions
from drf_spectacular.utils import extend_schema
from django.utils import timezone
from django.db.models import Q ,Avg ,F , Sum
from django.db import transaction
from datetime import datetime , timedelta
from .spectacular import ListOrdersSpectacular

# Create your views here.

def get_pending_price():
    price = GeneralServicesPrice.objects.aggregate(Sum('price'))
    return price['price__sum']

@transaction.atomic
def make_pending_balance(request , pending_balance , order):
    request.user.normal_user.balance.withdrawable_balance -= pending_balance
    request.user.normal_user.balance.pending_balance += pending_balance
    request.user.normal_user.balance.save()
    query = GeneralServicesPrice.objects.all()
    for thing in query :
        PendingBalance.objects.create(order = order , beneficiary = thing.beneficiary , price = thing.price).save()
    return True

@transaction.atomic
def retrieve_money_and_delete_order(request , pending_balance , order):
    request.user.normal_user.balance.withdrawable_balance+=pending_balance
    request.user.normal_user.balance.pending_balance -= pending_balance
    request.user.normal_user.balance.save()
    PendingBalance.objects.filter(order=order).delete()
    order.delete()
    return True

@transaction.atomic
def return_money_and_reject_order(request , pending_balance_except_seller , pending_balance_for_seller ,order, pending_objects_except_seller , pending_object_for_seller):
    order.status= "Rejected"
    order.save()
    request.user.normal_user.balance.pending_balance -= pending_balance_except_seller+pending_balance_for_seller
    request.user.normal_user.balance.withdrawable_balance += pending_balance_for_seller
    request.user.normal_user.balance.save()
    pending_object_for_seller.delete()

    for obj in pending_objects_except_seller :
        Earnings.objects.create(beneficiary = obj.beneficiary , earnings = obj.price , order = order).save()
    pending_objects_except_seller.delete()

    return True


class ListCategories(APIView):
    @extend_schema(
            responses={200:CategorySerializer(many=True)}
    )
    def get(self , request):
        queryset = Category.objects.all()
        serializer = CategorySerializer(data=queryset, many=True)
        serializer.is_valid()
        return Response(serializer.data , status=status.HTTP_200_OK)


class CreateOrderService(APIView):
    permission_classes =[permissions.IsAuthenticated]
    @extend_schema(
        request={201:OrderServiceSerializer , 400:None }
    )
    def post(self , request , home_service_id):
        try : 
            home_service = HomeService.objects.get(pk=home_service_id)
        except HomeService.DoesNotExist :
            return Response({"detail":"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        # if request.user.normal_user == home_service.seller:
        #     return Response({"detail":"You can't ask service from yourself."} , status=status.HTTP_400_BAD_REQUEST)
        pending_balance = get_pending_price()
        if request.user.normal_user.balance.withdrawable_balance < pending_balance :
            return Response ({"detail":"You don't have enough money to order , please charge your account" }, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = OrderServiceSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        order = serializer.save(home_service= home_service , client =request.user.normal_user , status='Pending')
        if not make_pending_balance(request=request , pending_balance= pending_balance , order=order):
            order.delete()
            return Response({"detail":"Something unexpected happened please try again "} , status=status.HTTP_400_BAD_REQUEST)
        return Response({'detail':"Created"} , status=status.HTTP_201_CREATED)

class AcceptOrderService(APIView):
    permission_classes=[permissions.IsAuthenticated]
    @extend_schema(
        responses={202:None , 403:None , 404 : None , 400:None}
    )
    def put(self , request , order_id):
        try :
            order = OrderService.objects.get(pk=order_id)
        except OrderService.DoesNotExist :
            return Response({'detail':"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user :
            return Response("Error 403 Forbidden", status=status.HTTP_403_FORBIDDEN)
        if order.answer_time :
            return Response({'detail':"Order already accepted"} , status=status.HTTP_400_BAD_REQUEST)
        #TODO open chat 
        order.answer_time=timezone.now()
        order.status = "Underway"
        order.save()

        average_fast_answer = OrderService.objects.filter(
            home_service__seller = request.user.normal_user , answer_time__isnull =False).aggregate(
            average_fast_answer = Avg(F('answer_time')- F('create_date')))['average_fast_answer']

        request.user.normal_user.average_fast_answer = average_fast_answer
        request.user.normal_user.save()
        return Response({'detail':"Order accepted successfully "} , status=status.HTTP_202_ACCEPTED)

class CancelOrderService(APIView):
    permission_classes= [permissions.IsAuthenticated]
    @extend_schema(
        responses={202:None , 403:None , 404 : None , 400:None}
    )
    def put(self , request , order_id):
        try :
            order = OrderService.objects.get(pk=order_id)
        except OrderService.DoesNotExist :
            return Response({'detail':"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        if order.client != request.user.normal_user :
            return Response("Error 403 Forbidden", status=status.HTTP_403_FORBIDDEN)
        if order.answer_time :
            return Response({'detail':"You can't cancel now ,the order already accepted"} , status=status.HTTP_400_BAD_REQUEST)
        
        pending_balance = int(PendingBalance.objects.filter(order= order).aggregate(Sum('price'))['price__sum'])
        if not retrieve_money_and_delete_order(request=request , order=order , pending_balance=pending_balance):
            return Response({"detail":"Error happened please try again."},status=status.HTTP_400_BAD_REQUEST)
        return Response({"detail":"Canceled successfully"} , status=status.HTTP_202_ACCEPTED)

class RejectOrder(APIView):
    permission_classes=[permissions.IsAuthenticated]
    @extend_schema(
        responses={202:None , 403:None , 404 : None , 400:None}
    )
    def put(self , request , order_id):
        try :
            order = OrderService.objects.get(pk=order_id)
        except OrderService.DoesNotExist :
            return Response({'detail':"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user :
            return Response("Error 403 Forbidden", status=status.HTTP_403_FORBIDDEN)
        if order.answer_time :
            return Response({'detail':"Order already accepted"} , status=status.HTTP_400_BAD_REQUEST)
        
        seller  = Beneficiary.objects.get(beneficiary_name = 'seller')
        pending_balance_for_seller = int(PendingBalance.objects.filter(order=order , beneficiary = seller).aggregate(Sum('price'))['price__sum'])
        pending_balance_except_seller = int(PendingBalance.objects.filter(order=order).aggregate(Sum('price'))['price__sum']) - pending_balance_for_seller
        pending_objects_except_seller = PendingBalance.objects.filter(order=order).filter(~Q(beneficiary = seller))
        pending_object_for_seller = PendingBalance.objects.filter(order=order , beneficiary = seller)
        if not return_money_and_reject_order(request ,pending_balance_except_seller ,pending_balance_for_seller ,order ,pending_objects_except_seller , pending_object_for_seller) : 
            return Response({"detail":"Error happened please try again."},status=status.HTTP_400_BAD_REQUEST)
        
        return Response({"detail":"Rejected successfully"} , status=status.HTTP_202_ACCEPTED)
    
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
        if request.user.mode == 'buyer':
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


class CreateHomeService(generics.CreateAPIView):
    serializer_class = CreateHomeServiceSerializer
    permission_classes = [permissions.IsAuthenticated]
    queryset = HomeService.objects.all()
    def perform_create(self, serializer):
        serializer.save(seller =self.request.user.normal_user)
    @extend_schema(
            responses={200 : CategorySerializer(many=True)},
            description="NOTE : The get response is list of categories"
    )
    def get(self , request):
        query= Category.objects.all()
        serializer = CategorySerializer(query , many=True)
        serializer.is_valid()
        return Response(serializer.data , status=status.HTTP_200_OK)
@extend_schema(
    description="NOTE : When you use this api use :<br> 1 - ( services/list_home_services?username=\{username\} ) to filter \
       the services for this user <br> 2 -  ( services/list_home_services?category=\{category\} ) to filter the services by category"
)
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
    
class HomeServiceDetail(generics.RetrieveAPIView):
    permission_classes=[permissions.AllowAny]
    serializer_class = ListHomeServicesSerializer
    queryset = HomeService.objects.all()

    

