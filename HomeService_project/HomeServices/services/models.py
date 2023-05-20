from django.db import models
from core.models import NormalUser as User
# Create your models here.


class Category(models.Model):
    name = models.CharField( max_length=50)

    def __str__(self) :
        return self.name

class Area(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self) :
        return self.name

class HomeService(models.Model):
    title = models.CharField(max_length=500)
    categories = models.ManyToManyField("Category" , related_name='home_services_categories')
    minimum_price = models.PositiveIntegerField()
    seller = models.ForeignKey(User , on_delete=models.CASCADE, related_name='home_services_seller')
    service_area = models.ManyToManyField("Area" , related_name='home_services_area_set')
    number_of_served_clients = models.PositiveIntegerField(default=0)
    average_ratings = models.IntegerField(default=0)
    def __str__(self) :
        return self.title

class OrderService(models.Model):
    client = models.ForeignKey(User, on_delete=models.CASCADE , related_name='client')
    create_date = models.DateTimeField( auto_now_add=True)
    description_message = models.CharField( max_length=1000)
    home_service = models.ForeignKey("HomeService",on_delete=models.CASCADE , related_name='home_service')
    answer_time = models.DateTimeField(auto_now=False, auto_now_add=False  , blank=True , null=True)
    end_service = models.DateTimeField(auto_now=False, auto_now_add=False  , blank=True , null=True)

    def __str__(self) :
        return str(self.client)+' ordered '+str(self.home_service)

class Rating(models.Model):
    quality_of_service = models.IntegerField()
    commitment_to_deadline = models.IntegerField()
    work_ethics = models.IntegerField()
    order_service = models.ForeignKey("OrderService" ,on_delete=models.CASCADE)
    client_comment = models.CharField(max_length=1000 , blank=True , null=True)
    seller_comment = models.CharField(max_length=1000 , blank=True , null=True)

    def __str__(self) :
        return self.order_service+' , Rating'
    
class PendingBalance(models.Model):
    price = models.PositiveIntegerField()
    order = models.ForeignKey("OrderService", on_delete=models.CASCADE)

    def __str__(self):
        return "pending price : "+str(self.price)+" , "+str(self.order)
    
class GeneralServicesPrice(models.Model):
    beneficiary_name = models.CharField(max_length=100)
    price = models.IntegerField()

    def __str__(self) :
        return self.beneficiary_name