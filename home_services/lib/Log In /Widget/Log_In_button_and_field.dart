import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/log_in_test_page.dart';
import 'package:home_services/my_field.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/log_in_style.dart';

// ignore: must_be_immutable
class LogInButtonAndField extends StatefulWidget {
  double height;
  String loginError;
  LogInButtonAndField({
    required this.height,
    required this.loginError,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LogInButtonAndFieldState();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.loginError.toString(),
          style: LogInStyle.errorStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        // username field
        MyFild(
          contorller: widget.usernameController,
          hintText: "username",
          obscure: false,
          lable: const Text("username"),
          color: Colors.white,
          sidesColor: Colors.black,
        ),

        const SizedBox(
          height: 15,
        ),

        // password field
        MyFild(
          contorller: widget.passwordController,
          hintText: "password",
          obscure: true,
          lable: const Text("password"),
          color: Colors.white,
          sidesColor: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30,top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.black,
                onTap: () {},
                child: Text(
                  "Forget password",
                  style: LogInStyle.forgetPasswordStyle(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 55,
        ),
        ElevatedButton(
          onPressed: () {
            //logIn();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogInApi(passwordController: widget.passwordController, usernameController: widget.usernameController)));
          },
          style: LogInStyle.buttonStyle(),
          child: Text(
            "Log in",
            style: LogInStyle.logInButtonTextStyle(),
          ),
        ),
      ])),
    );
  }
}