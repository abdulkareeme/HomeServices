from rest_framework import serializers
from .models import OrderService, HomeService 

from .serializers import CategorySerializer ,AreaSerializer

class HomeServiceSpectacular(serializers.ModelSerializer):
    categories = CategorySerializer(many=True)
    service_area = AreaSerializer(many=True)
    seller = serializers.CharField(max_length = 150)
    class Meta :
        model = HomeService
        fields = ['title','categories','average_price_per_hour','service_area' , 'seller' ]

class ListOrdersSpectacular(serializers.ModelSerializer):
    home_service = HomeServiceSpectacular()
    client = serializers.CharField(max_length = 150)
    class Meta : 
        model = OrderService
        fields = ['create_date','description_message','status','answer_time','end_service','home_service' , 'client']
