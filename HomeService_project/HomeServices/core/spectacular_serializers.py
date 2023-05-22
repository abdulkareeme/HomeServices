from rest_framework import serializers
from .models import User
class  LoginSpectacular(serializers.ModelSerializer):
    bio = serializers.CharField(max_length = 1000)
    average_fast_answer = serializers.DurationField()
    class Meta :
        model = User
        fields = ['id','username','email','first_name','last_name','mode','photo','birth_date','date_joined','gender','bio','average_fast_answer']