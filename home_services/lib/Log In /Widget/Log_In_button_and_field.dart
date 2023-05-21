import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/log_in_style.dart';

// ignore: must_be_immutable
class LogInButtonAndField extends StatefulWidget {
  double height;

  LogInButtonAndField({
    required this.height,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LogInButtonAndFieldState();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  @override
  Widget build(BuildContext context) {
    Future logIn() async {
      String url = "http://abdulkareemedres.pythonanywhere.com/api/login/";
      Response response = await http.post(Uri.parse(url), body: {
        'username': widget.usernameController.text,
        'password': widget.passwordController.text,
      });
      var info = jsonDecode(response.body);
      if(response.statusCode == 200){
        print("done");
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('username', info['user_info']['username']);
        pref.setString('username', info['user_info']['email']);
        pref.setString('username', info['user_info']['first_name']);
        pref.setString('username', info['user_info']['last_name']);
        pref.setString('username', info['user_info']['mode']);
        pref.setString('username', info['token'][0]);
        /*Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>));*/
      } else {
        setState(() {
          widget.error = "invalid username of password";
        });
      }
    }

    return Form(
      child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.error.toString(),
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
            logIn();
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
