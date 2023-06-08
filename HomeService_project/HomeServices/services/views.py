from django.shortcuts import render
from rest_framework.views import APIView
from .models import Category ,Area,HomeService ,OrderService ,Rating  ,GeneralServicesPrice , Beneficiary , Earnings
from .serializers import AreaSerializer ,CategorySerializer  , RatingSerializer  , ListOrdersSerializer  ,ListHomeServicesSerializer , RetrieveHomeServices
from rest_framework.response import Response
from rest_framework import status , generics
from rest_framework import permissions
from drf_spectacular.utils import extend_schema
from django.utils import timezone
from django.db.models import Q ,Avg ,F , Sum
from django.db import transaction
from datetime import datetime , timedelta
from .spectacular import ListOrdersSpectacular


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
    
@extend_schema(
    responses={200:RetrieveHomeServices}
)
class HomeServiceDetail(generics.RetrieveAPIView):
    permission_classes=[permissions.AllowAny]
    serializer_class = RetrieveHomeServices
    queryset = HomeService.objects.all()    


    

