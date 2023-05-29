from rest_framework import serializers
from .models import HomeService , Area , Category ,OrderService , Rating , PendingBalance
from rest_framework.validators import ValidationError
from core.models import NormalUser , User

class AreaSerializer(serializers.ModelSerializer):
    class Meta :
        model = Area
        fields = '__all__'
class AreaBYIdSerializer(serializers.ModelSerializer):
    class Meta :
        model = Area
        field = 'id'

class CategorySerializer(serializers.ModelSerializer):
    class Meta :
        model = Category
        fields = '__all__'

class UsernameSerializer(serializers.ModelSerializer):
    class Meta :
        model = User
        fields = ['username']
class NormalUsernameSerializer(serializers.ModelSerializer):
    user = UsernameSerializer()
    class Meta:
        model = User
        fields = ['user']

class HomeServiceSerializer(serializers.ModelSerializer):
    categories = CategorySerializer(many=True)
    service_area = AreaSerializer(many=True)
    class Meta :
        model = HomeService
        fields = ['title','categories','average_price_per_hour','service_area' ]

class OrderServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderService
        fields = ['description_message']

class RatingSerializer(serializers.ModelSerializer):
    client_comment = serializers.CharField(required = False)

    def validate(self, attrs):
        if attrs['quality_of_service'] <1 or attrs['quality_of_service'] >5 :
            raise ValidationError('value must be between 1 and 5')
        if attrs['commitment_to_deadline'] <1 or attrs['commitment_to_deadline'] >5 :
            raise ValidationError('value must be between 1 and 5')
        if attrs['work_ethics'] <1 or attrs['work_ethics'] >5 :
            raise ValidationError('value must be between 1 and 5')
        return super().validate(attrs)
    class Meta:
        model = Rating
        fields = ['quality_of_service','commitment_to_deadline','work_ethics','order_service','client_comment']

class PendingBalanceSerializer(serializers.ModelSerializer):
    class Meta :
        model = PendingBalance
        fields = ['beneficiary','price']

class ListOrdersSerializer(serializers.ModelSerializer):
    home_service = HomeServiceSerializer()
    class Meta : 
        model = OrderService
        fields = ['create_date','description_message','status','answer_time','end_service','home_service']

class CreateHomeServiceSerializer(serializers.ModelSerializer):
    class Meta :
        model = HomeService
        fields = ['title','category','average_price_per_hour','service_area']

class ListHomeServicesSerializer(serializers.ModelSerializer):
    class Meta :
        model = HomeService
        fields = '__all__'