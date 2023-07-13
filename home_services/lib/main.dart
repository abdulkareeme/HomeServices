import 'package:flutter/material.dart';
import 'package:home_services/forget_password/Screen/send_email.dart';
import 'Log In /Widget/Log_In_page.dart';
import 'Log In /Widget/check_if_user_logged_in.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String error = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      const SendEmailForForgetPassword(),//CheckIfLoggedIn(), //HomePage(user: null,),////*LogIn(error: error),*//*CodeVerificationPage(email: "abode2001a123@gmail.com"),*/CheckIfLoggedIn(),//*CodeVerificationPage(email: "abode2001a123@gmail.com"),*///LogIn(error: error),//CheckIfLoggedIn(),//FirstPageOfSignUp(areaList: op),//CheckIfLoggedIn()LogIn(error: error),HomePage(userInfo: op),
      routes: {
        "log in": (context) => LogIn(
              error: error,
            ),
      },
    );
  }
}
