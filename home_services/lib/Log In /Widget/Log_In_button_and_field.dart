import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

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
  String usernameError = "";
  String passwordError = "";
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: widget.height / 3,
        ),
        // username field
        MyFild(
          errorText: widget.usernameError,
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
          errorText: widget.passwordError,
          contorller: widget.passwordController,
          hintText: "password",
          obscure: true,
          lable: const Text("password"),
          color: Colors.white,
          sidesColor: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.black,
                onTap: () {

                },
                child: Text(
                  "Forget password", style: LogInStyle.forgetPasswordStyle(),),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {},
          style: LogInStyle.buttonStyle(),
          child: Text(
            "Log in",
            style: LogInStyle.logInButtonTextStyle(),
          ),
        ),
        SizedBox(height: widget.height-20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("")
          ],
        )
      ])),
    );
  }
}
