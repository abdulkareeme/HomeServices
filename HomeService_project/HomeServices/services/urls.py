from django.urls import path
from . import views
urlpatterns = [
    path('categories' , views.ListCategories.as_view()),
    path('list_all_area' ,views.ListArea.as_view() ),
    path('my_orders' , views.MyOrders.as_view()),
    path('received_orders' , views.ReceivedOrders.as_view()),
    path('list_home_services' , views.ListHomeServices.as_view()),
    path('home_service/detail/<int:pk>' , views.HomeServiceDetail.as_view()),
    path('create_service' , views.CreateHomeService.as_view()),
    path('retrieve_update_home_service/<int:home_service_id>' , views.RetrieveUpdateHomeService.as_view()),
    path('delete_home_service/<int:home_service_id>' , views.DeleteHomeService.as_view()),
    path('update_form_home_service/<int:home_service_id>', views.UpdateFormHomeService.as_view()),
    path('order_service/<int:service_id>', views.MakeOrderService.as_view()),
    path('cancel_order/<int:order_id>',views.CancelOrder.as_view()),
    path('reject_order/<int:order_id>',views.RejectOrder.as_view()),
    path('accept_order/<int:order_id>',views.AcceptOrder.as_view()),
    path('accept_after_review/<int:order_id>', views.AcceptAfterUnderReview.as_view()),
    path('reject_after_review/<int:order_id>',views.RejectAfterUnderReview.as_view()),
    path('finish_order/<int:order_id>', views.FinishOrder.as_view()),
    path('make_rating/<int:order_id>',views.MakeRateAndComment.as_view()),
    

]
