import 'package:flutter/material.dart';
import 'Log In /Widget/Log_In_page.dart';
import 'On Boarding Screen/Widget/on_boarding_screen.dart';

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
      home: OnBoardingScreen(),
      routes: {
        "log in": (context) => LogIn(
              error: error,
            ),
      },
    );
  }
}
