from rest_framework import serializers
from .models import User

class  LoginSpectacular(serializers.ModelSerializer):
    bio = serializers.CharField(max_length = 1000)
    average_fast_answer = serializers.DurationField()
    clients_number  = serializers.IntegerField()
    services_number = serializers.IntegerField()
    class Meta :
        model = User
        fields = ['id','username','email','first_name','last_name',
                  'mode','photo','birth_date','date_joined','gender','bio','average_fast_answer' ,'clients_number','services_number']

class ListAreaSpectacular(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()
class UpdateProfileSpectacular(serializers.ModelSerializer):
    bio = serializers.CharField(max_length = 1000)
    average_fast_answer = serializers.DurationField()
    clients_number  = serializers.IntegerField()
    services_number = serializers.IntegerField()
    area = ListAreaSpectacular(many=True)
    class Meta :
        model = User
        fields = ['id','username','email','first_name','last_name',
                  'mode','photo','birth_date','date_joined','gender','bio','average_fast_answer' ,'clients_number','services_number' , 'area']
        

class ResendCodeEmailSpectacular(serializers.Serializer):
    email = serializers.EmailField(
        required=True,
    )
class ConfirmCodeSpectacular(serializers.Serializer):
    email = serializers.EmailField(
        required=True,
    )
    confirmation_code = serializers.CharField()