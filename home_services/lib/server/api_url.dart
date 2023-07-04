class Server{
  static const String host = "https://abdulkareemedres.pythonanywhere.com/";
  static const String loginApi = "api/login/";
  static const String signupApi = "api/register/";
  static const String userConfirmCode = "api/confirm_email";
  static const String logOut = "api/logout/";
  static const String updateInfo = "api/update_profile";
  static const String resendCode ="api/resend_email_code";
  static const String listCategories = "services/categories";
  static const String createService = "services/create_service";
  static const String listMyService = "services/list_home_services";
  static const String serviceDetails= "services/home_service/detail/";
  static const String deleteService = "services/delete_home_service/";
  static const String getServiceForm = "services/update_form_home_service/";
  static const String updateServiceMainData= "services/retrieve_update_home_service/";
  static const String updateServiceForm= "services/update_form_home_service/";
  static const String getUserDetails = "api/user/";
  static const String makeOrder= "services/order_service/";
  static const String orderServiceForm = "services/order_service/";
  static const String mySentOrder = "services/my_orders";
  static const String myReceivedOrder = "services/received_orders";
  static const String deleteOrder = "services/cancel_order/";
  static const String firstRejectForOrder = "services/reject_order/";
}