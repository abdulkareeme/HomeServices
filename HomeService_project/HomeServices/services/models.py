from django.db import models
from core.models import NormalUser as User
# Create your models here.


class Category(models.Model):
    name = models.CharField( max_length=50)
    photo = models.ImageField( upload_to='categories',max_length=50 , null=True , blank=True)
    def __str__(self) :
        return self.name

class Area(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self) :
        return self.name

class HomeService(models.Model):
    title = models.CharField(max_length=100)
    description = models.CharField( max_length=500 )
    category = models.ForeignKey("Category" , related_name='home_services_categories' , on_delete=models.CASCADE) #TODO set default
    average_price_per_hour = models.PositiveIntegerField()
    seller = models.ForeignKey(User , on_delete=models.CASCADE, related_name='home_services_seller')
    service_area = models.ManyToManyField("Area" , related_name='home_services_area_set')
    number_of_served_clients = models.PositiveIntegerField(default=0)
    average_ratings = models.IntegerField(default=0)
    def __str__(self) :
        return self.title

status_choices =[('Underway','Underway') , ('Expire','Expire') , ('Pending' , 'Pending') , ('Rejected' , 'Rejected')] 

class OrderService(models.Model):
    client = models.ForeignKey(User, on_delete=models.CASCADE , related_name='client')
    create_date = models.DateTimeField( auto_now_add=True)
    description_message = models.CharField( max_length=1000)
    home_service = models.ForeignKey("HomeService",on_delete=models.CASCADE , related_name='order_home_service')
    status = models.CharField(choices=status_choices, max_length=50 , default='Pending')
    answer_time = models.DateTimeField(auto_now=False, auto_now_add=False  , blank=True , null=True)
    end_service = models.DateTimeField(auto_now=False, auto_now_add=False  , blank=True , null=True)
    form_data = models.ManyToManyField("InputData", related_name="order_form_data")
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

class Beneficiary(models.Model):
    beneficiary_name = models.CharField( max_length=100)

    def __str__(self):
        return self.beneficiary_name
    
    
class GeneralServicesPrice(models.Model):
    beneficiary = models.OneToOneField("Beneficiary", on_delete=models.SET_NULL  , null=True)
    price = models.PositiveIntegerField()

    def __str__(self) :
        return str(self.beneficiary)
    
class Earnings(models.Model):
    order = models.ForeignKey("OrderService", on_delete=models.SET_NULL , related_name='earnings_order'  , null=True)
    beneficiary= models.ForeignKey("Beneficiary", on_delete=models.SET_NULL  , null=True , related_name='earnings_beneficiary')
    earnings = models.IntegerField()

    def __str__(self) :
        return str(self.beneficiary)+' '+str(self.earnings)
    
input_choices = [('text','text'),('number','number')]
class InputField(models.Model):
    title = models.CharField(max_length=100)
    field_type  = models.CharField(max_length=50  , choices=input_choices , default='TEXT')
    note = models.CharField( max_length=100 , default='' , blank=True)
    home_service = models.ForeignKey("HomeService", on_delete=models.CASCADE , related_name='field') 
    def __str__(self) :
        return self.title + ' : '+self.field_type

class InputData(models.Model):
    field = models.ForeignKey("InputField", on_delete=models.CASCADE , related_name='field_data')
    content = models.CharField( max_length=500)

    def __str__(self) :
        return str(self.field)