from rest_framework import serializers
from .models import HomeService , Area , Category ,OrderService , Rating , InputField , input_choices
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
        fields = ['username','first_name' , 'last_name' , 'photo']
class NormalUsernameSerializer(serializers.ModelSerializer):
    user = UsernameSerializer()
    class Meta:
        model = User
        fields = ['user']

class HomeServiceSerializer(serializers.ModelSerializer):
    service_area = AreaSerializer(many=True)
    class Meta :
        model = HomeService
        fields = ['title','category','average_price_per_hour','service_area' ]
        depth =2

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

class ListOrdersSerializer(serializers.ModelSerializer):
    home_service = HomeServiceSerializer()
    class Meta : 
        model = OrderService
        fields = ['create_date','description_message','status','answer_time','end_service','home_service']

class ListHomeServicesSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    service_area = AreaSerializer(many=True)
    seller = NormalUsernameSerializer()
    class Meta :
        model = HomeService
        fields = ['id','title','category','average_price_per_hour','seller','service_area','average_ratings']

class RetrieveHomeServices(serializers.ModelSerializer):
    category = CategorySerializer()
    service_area = AreaSerializer(many=True)
    seller = NormalUsernameSerializer()
    class Meta :
        model = HomeService
        fields = ['id','title','description','category','average_price_per_hour','seller','service_area','number_of_served_clients','average_ratings']

class InputFieldSerializer(serializers.ModelSerializer):
    field_type = serializers.ChoiceField(choices=input_choices , required = True)
    class Meta :
        model = InputField
        fields = ['title','field_type' , 'note']

class CreateHomeServiceSerializer(serializers.ModelSerializer):
    form = InputFieldSerializer(many=True, write_only=True)
    class Meta:
        model = HomeService
        fields = ['title', 'description', 'category', 'average_price_per_hour', 'service_area', 'form']

    def validate_form(self, value):
        if len(value) < 3 or len(value) > 10:
            raise serializers.ValidationError("Number of fields must be between 3 and 10")
        return value

    def validate_average_price_per_hour(self, value):
        if value <= 0:
            raise serializers.ValidationError("Average price per hour must be greater than 0")
        return value

    def create(self, validated_data):
        form_data = validated_data.pop('form')
        service_area_data = validated_data.pop('service_area')
        home_service = HomeService.objects.create(seller = self.context['request'].user.normal_user , **validated_data)
        home_service.save()
        for field_data in form_data:
            InputField.objects.create(home_service=home_service, **field_data)

        service_area_data = set(service_area_data)

        for area in service_area_data :
            home_service.service_area.add(area)
        return home_service
    
class RetrieveUpdateHomeServiceSerializer(serializers.ModelSerializer):
    class Meta :
        model = HomeService
        fields =['title','description','average_price_per_hour','service_area']