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

gender_choices = [('Male', 'M'), ('Female', 'F')]
mode_choices = [('buyer', 'buyer'), ('seller_buyer', 'seller_buyer')]

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
        fields = ('username', 'password', 'password2', 'email', 'first_name', 'last_name','birth_date' , 'gender','photo','mode')
        extra_kwargs = {
            'first_name': {'required': True},
            'last_name': {'required': True},
            
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
            birth_date=validated_data.get('birth_date',None),
            gender=validated_data['gender'],
            photo=validated_data.get('photo', None),
            mode=validated_data['mode'],
        )
        user.set_password(validated_data['password'])
        user.is_active = False
        user.save()
        token = default_token_generator.make_token(user)
        uid = urlsafe_base64_encode(force_bytes(user.pk))
        confirm_url = reverse('confirm_email', kwargs={'uidb64': uid, 'token': token})
        confirm_url = self.context['request'].build_absolute_uri(confirm_url)
        subject = 'Confirm your email'
        message = f'Please click the following link to confirm your email address: {confirm_url}'
        email_from = settings.EMAIL_HOST_USER
        recipient_list = [user.email,]    
        send_mail( subject, message, email_from, recipient_list )
        return user

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
    class Meta :
        model = User
        fields = ['username','first_name','last_name','photo' ,'categories']

class  RetrieveUserSerializer(serializers.ModelSerializer):
    bio = serializers.CharField(max_length = 1000)
    class Meta :
        model = User
        fields = ['id','username','email','first_name','last_name','mode','photo','birth_date','date_joined','gender','bio']