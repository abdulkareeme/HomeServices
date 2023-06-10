import 'package:flutter/material.dart';
import 'Home Page/home_page.dart';
import 'Log In /Widget/Log_In_page.dart';
import 'Log In /Widget/check_if_user_logged_in.dart';
import 'Sign up/Widget/first_page_of_signup.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String error = "";
  List op = ['latttta','dama'];

  @override
  Widget build(BuildContext context) {
    List op = ['lattakia','damascus'];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPageOfSignUp(areaList: op),//CheckIfLoggedIn(),//LogIn(error: error),//HomePage(userInfo: op),
      routes: {
        "log in": (context) => LogIn(
              error: error,
            ),
      },
    );
  }
}
