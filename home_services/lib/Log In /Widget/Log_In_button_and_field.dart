import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

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
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [

         SizedBox(height: widget.height/3,),
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
            sidesColor:Colors.black,
        )
      ])),
    );
  }
}
