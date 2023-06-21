from rest_framework import serializers
from .models import OrderService, HomeService 

from .serializers import CategorySerializer ,AreaSerializer

class HomeServiceSpectacular(serializers.ModelSerializer):
    service_area = AreaSerializer(many=True)
    seller = serializers.CharField(max_length = 150)
    class Meta :
        model = HomeService
        fields = ['title','category','average_price_per_hour','service_area' , 'seller' ]
        depth=2

class ListOrdersSpectacular(serializers.ModelSerializer):
    home_service = HomeServiceSpectacular()
    client = serializers.CharField(max_length = 150)
    class Meta : 
        model = OrderService
        fields = ['id','create_date','status','home_service' , 'client']
