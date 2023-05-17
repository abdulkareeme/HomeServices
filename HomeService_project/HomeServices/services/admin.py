from django.contrib import admin
from .models import Area,Category , OrderService ,Rating ,HomeService
# Register your models here.
admin.site.register(Area)
admin.site.register(Category)
admin.site.register(OrderService)
admin.site.register(Rating)
admin.site.register(HomeService)
