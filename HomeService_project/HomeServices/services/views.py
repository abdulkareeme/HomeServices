from django.shortcuts import render
from rest_framework.views import APIView
from .models import Category ,Area,HomeService ,OrderService ,Rating ,PendingBalance ,GeneralServicesPrice
from .serializers import AreaSerializer ,CategorySerializer ,HomeServiceSerializer ,OrderServiceSerializer , RatingSerializer 
from rest_framework.response import Response
from rest_framework import status
from rest_framework import permissions
from drf_spectacular.utils import extend_schema
from django.utils import timezone
from django.db.models import Q ,Avg ,F , Sum
from django.db import transaction
from datetime import datetime , timedelta

# Create your views here.

def get_pending_price():
    price = GeneralServicesPrice.objects.aggregate(Sum('price'))
    return price['price__sum']

@transaction.atomic
def make_pending_balance(request , pending_balance , order):
    request.user.normal_user.balance.withdrawable_balance -= pending_balance
    request.user.normal_user.balance.pending_balance += pending_balance
    request.user.normal_user.balance.save()
    PendingBalance.objects.create(price = pending_balance , order = order).save()
    return True

class ListCategories(APIView):
    def get(self , request):
        queryset = Category.objects.all()
        serializer = CategorySerializer(data=queryset, many=True)
        serializer.is_valid()
        return Response(serializer.data , status=status.HTTP_200_OK)


class CreateOrderService(APIView):
    permission_classes =[permissions.IsAuthenticated]
    @extend_schema(
        request=OrderServiceSerializer
    )
    def post(self , request , pk):
        try : 
            home_service = HomeService.objects.get(pk=pk)
        except HomeService.DoesNotExist :
            return Response({"detail":"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        if request.user.normal_user == home_service.seller:
            return Response({"detail":"You can't ask service from yourself."} , status=status.HTTP_400_BAD_REQUEST)
        pending_balance = get_pending_price()
        if request.user.normal_user.balance.withdrawable_balance <pending_balance :
            return Response ({"detail":"You don't have enough money to order , please charge your account" }, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = OrderServiceSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        order = serializer.save(home_service= home_service , client =request.user.normal_user)
        if not make_pending_balance(request=request , pending_balance= pending_balance , order=order):
            order.delete()
            return Response({"detail":"Something unexpected happened please try again "} , status=status.HTTP_400_BAD_REQUEST)
        return Response({'detail':"Created"} , status=status.HTTP_201_CREATED)

class AcceptOrderService(APIView):
    permission_classes=[permissions.IsAuthenticated]
    def put(self , request , pk):
        try :
            order = OrderService.objects.get(pk=pk)
        except OrderService.DoesNotExist :
            return Response({'detail':"Error 404 Not Found"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user :
            return Response("Error 403 Forbidden", status=status.HTTP_403_FORBIDDEN)
        if order.answer_time :
            return Response({'detail':"Order already accepted"} , status=status.HTTP_400_BAD_REQUEST)
        #TODO open chat 
        order.answer_time=timezone.now()
        order.save()

        average_fast_answer = OrderService.objects.filter(
            home_service__seller = request.user.normal_user , answer_time__isnull =False).aggregate(
            average_fast_answer = Avg(F('answer_time')- F('create_date')))['average_fast_answer']
        print(average_fast_answer)

        request.user.normal_user.average_fast_answer = average_fast_answer
        request.user.normal_user.save()
        return Response({'detail':"Order accepted successfully "})

