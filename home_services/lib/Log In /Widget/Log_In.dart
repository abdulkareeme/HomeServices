import 'package:flutter/material.dart';
import 'Log_In_button_and_field.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.yellow,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Log in button and field
                LogInButtonAndField(height: height),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
