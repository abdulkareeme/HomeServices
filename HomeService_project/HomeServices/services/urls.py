from django.urls import path
from . import views
urlpatterns = [
    path('categories' , views.ListCategories.as_view()),
    path('create/order/<int:home_service_id>' , views.CreateOrderService.as_view()),
    path('accept/order/<int:order_id>' , views.AcceptOrderService.as_view()),
    path('cancel/order/<int:order_id>',views.CancelOrderService.as_view()),
    path('reject/order/<int:order_id>' , views.RejectOrder.as_view()),
    path('my_orders' , views.MyOrders.as_view()),
    path('received_orders' , views.ReceivedOrders.as_view()),
    path('create_service' , views.CreateHomeService.as_view()),
    path('list_home_services' , views.ListHomeServices.as_view()),
    path('home_service/detail/<int:pk>' , views.HomeServiceDetail.as_view()),
]
