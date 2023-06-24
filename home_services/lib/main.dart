import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Widget/get_area_list.dart';
import 'Home Page/home_page.dart';
import 'Log In /Widget/Log_In_page.dart';
import 'Log In /Widget/check_if_user_logged_in.dart';
import 'Sign up/Widget/code_verification_page.dart';
import 'Sign up/Widget/first_page_of_signup.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String error = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CheckIfLoggedIn(),//HomePage(user: null,),////*LogIn(error: error),*//*CodeVerificationPage(email: "abode2001a123@gmail.com"),*/CheckIfLoggedIn(),//*CodeVerificationPage(email: "abode2001a123@gmail.com"),*///LogIn(error: error),//CheckIfLoggedIn(),//FirstPageOfSignUp(areaList: op),//CheckIfLoggedIn()LogIn(error: error),HomePage(userInfo: op),
      routes: {
        "log in": (context) => LogIn(
              error: error,
            ),
      },
    );
  }
}
