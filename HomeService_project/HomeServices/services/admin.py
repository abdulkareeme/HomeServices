from django.contrib import admin
from .models import Area,Category , OrderService ,Rating ,HomeService ,PendingBalance ,GeneralServicesPrice , Earnings ,Beneficiary
# Register your models here.
admin.site.register(Area)
admin.site.register(Category)
admin.site.register(OrderService)
admin.site.register(Rating)
admin.site.register(HomeService)
admin.site.register(PendingBalance)
admin.site.register(GeneralServicesPrice)
admin.site.register(Earnings)
admin.site.register(Beneficiary)