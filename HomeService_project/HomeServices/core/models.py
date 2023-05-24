from django.db import models
from django.contrib.auth.models import AbstractUser


gender_choices = [('Male','M') , ('Female','F') ]
mode_choices = [('client','buyer') , ('seller' , 'seller_buyer')]

class User(AbstractUser):
    birth_date = models.DateField(blank=True , null=True)
    gender = models.CharField(choices=gender_choices , max_length=10 )
    photo = models.ImageField( upload_to='profile', max_length=100 , blank=True  , null=True)
    mode = models.CharField(choices=mode_choices , max_length=50 )
    area = models.ForeignKey("services.Area" ,on_delete=models.SET_NULL , null = True)

class NormalUser(models.Model):
    bio = models.CharField( max_length=10000,default="")
    user= models.OneToOneField("User", on_delete=models.CASCADE , related_name='normal_user')
    average_fast_answer = models.DurationField(blank=True , null= True)

    def __str__(self):
        return self.user.username

class Balance(models.Model):
    user = models.OneToOneField("NormalUser", on_delete=models.CASCADE , related_name='balance')
    total_balance = models.PositiveIntegerField(default=0)
    pending_balance = models.PositiveIntegerField(default=0)
    withdrawable_balance = models.PositiveIntegerField(default=0)
    def __str__(self):
        return self.user.user.username
