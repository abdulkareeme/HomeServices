from django.urls import path
from . import  views


urlpatterns = [
    path('login/', views.login_api, name='login_api'),
    path('user_info/', views.user_info, name='user_info'),
    path('register/', views.register_api, name='register_api'),
    path('confirm-email/<str:uidb64>/<str:token>/', views.UserConfirmEmailView.as_view(), name='confirm_email'),
    # path('photos/<str:filename>', views.PhotoView.as_view(), name='photo_view'),
]