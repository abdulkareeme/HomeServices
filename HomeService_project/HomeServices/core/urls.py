from django.urls import path
from . import  views
from knox.views import LogoutView


urlpatterns = [
    path('login/', views.login_api, name='login_api'),
    path('register/', views.RegisterUser.as_view(), name='register_api'),
    path('users', views.ListUsers.as_view() , name = 'list_users'),
    path('user/<str:username>', views.RetrieveUser.as_view() , name='retrieve_user'), 
    path('logout/',LogoutView.as_view() , name='logout'),
    path('password_reset/', views.PasswordResetAPIView.as_view(), name='password_reset'),
    path('update_profile', views.UpdateUser.as_view() , name = 'update_profile'),
    path('confirm_email' , views.UserConfirmMessage.as_view() , name = 'confirm_email'),
    path('resend_email_code' , views.ResendEmailMessage.as_view()  , name = 'resend_email_code'),
    path('my_balance', views.RetrieverMyBalance.as_view()  , name = 'my_balance'),
    path('send_forget_password_code' , views.SendForgetPasswordCode.as_view() , name = 'send_forget_password_code' ),
    path('forget_password_reset', views.ForgetPasswordReset.as_view() , name='forget_password_reset' ),
    path('check_forget_password_code',views.CheckForgetPasswordCode.as_view() , name  ='check_forget_password_code'),
]
