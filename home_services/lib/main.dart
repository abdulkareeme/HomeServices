import 'package:flutter/material.dart';

import 'Log In /Widget/Log_In.dart';
import 'On Boarding Screen/Widget/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:OnBoardingScreen(),
      routes: {
        "log in" : (context)=> LogIn(),
      },
    );
  }

}
