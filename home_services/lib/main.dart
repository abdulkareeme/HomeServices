import 'package:flutter/material.dart';
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
      home: CheckIfLoggedIn(),
    );
  }
}
