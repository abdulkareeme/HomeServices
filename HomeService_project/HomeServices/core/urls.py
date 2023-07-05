from django.urls import path
from . import  views
from knox.views import LogoutView


urlpatterns = [
    path('login/', views.login_api, name='login_api'),
    # path('user_info/', views.user_info, name='user_info'),
    path('register/', views.RegisterUser.as_view(), name='register_api'),
    # path('confirm-email/<str:uidb64>/<str:token>/', views.UserConfirmEmailView.as_view(), name='confirm_email'),
    path('users', views.ListUsers.as_view()),
    path('user/<str:username>', views.RetrieveUser.as_view()), 
    path('logout/',LogoutView.as_view() , name='logout'),
    path('password_reset/', views.PasswordResetAPIView.as_view(), name='password_reset'),
    path('update_profile', views.UpdateUser.as_view()),
    path('confirm_email' , views.UserConfirmMessage.as_view()),
    path('resend_email_code' , views.ResendEmailMessage.as_view() ),
    path('my_balance', views.RetrieverMyBalance.as_view() ),
    path('send_forget_password_code' , views.SendForgetPasswordCode.as_view() ),
    path('forget_password_reset', views.ForgetPasswordReset.as_view()),
    path('check_forget_password_code',views.CheckForgetPasswordCode.as_view()),
]
