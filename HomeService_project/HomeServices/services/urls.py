from django.urls import path
from . import views
urlpatterns = [
    path('categories' , views.ListCategories.as_view()),
    path('create/order/<int:pk>' , views.CreateOrderService.as_view()),
    path('accept/order/<int:pk>' , views.AcceptOrderService.as_view()),
    
]
