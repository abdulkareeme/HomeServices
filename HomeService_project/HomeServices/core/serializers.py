from rest_framework import serializers
from .models import User , Balance , NormalUser
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from django.utils.http import urlsafe_base64_encode ,urlsafe_base64_decode
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes
from django.urls import reverse
from django.utils import timezone
from django.core.mail import send_mail
from django.conf import settings
from rest_framework.validators import ValidationError
from services.serializers import CategorySerializer
import random
from datetime import timedelta

gender_choices = [('Male', 'M'), ('Female', 'F')]
mode_choices = [('client', 'buyer'), ('seller', 'seller_buyer')]

class UserConfirmEmailSerializer(serializers.Serializer):
    uidb64 = serializers.CharField()
    token = serializers.CharField()

    def validate(self, data):
        try:
            uid = urlsafe_base64_decode(data['uidb64']).decode()
            user = User.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            user = None
        if user is not None and default_token_generator.check_token(user, data['token']):
            user.is_active = True
            user.email_confirmed_at = timezone.now()
            user.save()
            return data
        else:
            raise serializers.ValidationError('Invalid or expired confirmation link')
        

class BalanceSerializer(serializers.ModelSerializer):
    class Meta :
        model= Balance 
        fields = ['total_balance','pending_balance','withdrawable_balance','earnings']

class NormalUserSerializer(serializers.ModelSerializer):
    class Meta :
        model = NormalUser
        fields = ['bio']

class ListUsersSerializer(serializers.ModelSerializer):
    categories = CategorySerializer(many=True)
    average_rating = serializers.FloatField()
    class Meta :
        model = User
        fields = ['username','first_name','last_name','photo' ,'categories','average_rating']

class  RetrieveUserSerializer(serializers.ModelSerializer):
    bio = serializers.CharField(max_length = 1000)
    class Meta :
        model = User
        fields = ['id','username','email','first_name','last_name','mode','photo','birth_date','date_joined','gender','bio']

class PasswordResetSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)
    new_password2= serializers.CharField(required=True)
    def validate_new_password(self, value):
        user = self.context['request'].user
        try:
            validate_password(password=value, user=user)
        except ValidationError as e:
            raise serializers.ValidationError(e.messages)
        return value
    def validate_old_password(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError("Incorrect password.")
        return value
    def validate(self, attrs):
        if attrs['new_password'] != attrs['new_password2'] : 
            raise serializers.ValidationError({"password": "New password fields didn't match."})
        return super().validate(attrs)
    

class RegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
            required=True,
            validators=[UniqueValidator(queryset=User.objects.all())]
            )

    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    birth_date = serializers.DateField(required=False)
    gender = serializers.ChoiceField(choices=gender_choices, required=True)
    photo = serializers.ImageField(max_length=100, use_url=True, required=False)
    mode = serializers.ChoiceField(choices=mode_choices, required=True)

    class Meta:
        model = User
        fields = ('username', 'password', 'password2', 'email', 'first_name', 'last_name', 'birth_date', 'gender', 'photo', 'mode', 'area')
        extra_kwargs = {
            'first_name': {'required': True},
            'last_name': {'required': True},
            'area': {'required': True}
        }

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})

        return attrs

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username'],
            email=validated_data['email'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            birth_date=validated_data.get('birth_date', None),
            gender=validated_data['gender'],
            photo=validated_data.get('photo', None),
            mode=validated_data['mode'],
            area=validated_data['area']
        )
        user.set_password(validated_data['password'])
        user.is_active = False
        user.confirmation_tries = 3
        user.resend_tries = 2
        user.confirmation_code = str(random.randint(100000, 999999))
        user.save()

        subject = 'Confirm your email'
        message = f'Please use the following 6-digit code to confirm your email address: {user.confirmation_code}'
        email_from = settings.EMAIL_HOST_USER
        recipient_list = [user.email,]
        send_mail(subject, message, email_from, recipient_list)
        return user

class UpdateUserSerializer(serializers.ModelSerializer):
    class Meta :
        model = User
        fields = ['first_name','last_name','birth_date','photo','area']

class UpdateNormalUser(serializers.ModelSerializer):
    user = UpdateUserSerializer()
    class Meta :
        model = NormalUser
        fields = ['bio','user']

    def update(self, instance, validated_data):
        user_data = validated_data.pop('user', None)
        if user_data:
            user_serializer = UpdateUserSerializer(instance=instance.user, data=user_data)
            user_serializer.is_valid(raise_exception=True)
            user_serializer.save()
        
        return super().update(instance, validated_data)

# class ConfirmMessageSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = ['confirmation_code']
    
#     def validate(self, attrs):
#         if self.context['request'].user.is_active :
#             return ValidationError("Email already verified")
        
#         if self.context['request'].user.next_confirm_try is not None and self.context['request'].user.next_confirm_try <= timedelta.now() :
#             self.context['request'].user.confirmation_tries = 3
#             self.context['request'].user.save()

#         if self.context['request'].user.confirmation_tries == 0 :
#             return ValidationError(f"Try again after{self.context['request'].user.next_confirm_try - timezone.now()}")
        
#         if self.context['request'].user.confirmation_code != self.context['request'].POST.get('confirmation_code' , None):
#             self.context['request'].user.is_active = True

#         else :
#             self.context['request'].user.confirmation_tries -=1
#             if self.context['request'].user.confirmation_tries ==0 :
#                 self.context['request'].user.next_confirm_try = timezone.now() + timedelta(hours=24)
#                 return Response({"detail":f"Try again after{self.context['request'].user.next_confirm_try - timezone.now()}"} ,status=status.HTTP_400_BAD_REQUEST)
#             return Response({"detail":"Wrong code please try again"} , status=status.HTTP_400_BAD_REQUEST)
#         return super().validate(attrs)