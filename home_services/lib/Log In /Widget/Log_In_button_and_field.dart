import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/log_in .dart';
import 'package:home_services/forget_password/Screen/send_email.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/Log out/Api/Log_out_Api.dart';
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
  bool isPasswordVisible1 = false;
  LogOutApi op = LogOutApi();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(children: [
        Text(
          widget.loginError.toString(),
          style: LogInStyle.errorStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        // username field
        MyFild(
          leftPadding: 20.0,
          rightPadding: 20.0,
          contorller: widget.usernameController,
          hintText: "البريد الالكتروني",
          obscure: false,
          lable: const Text("البريد الالكتروني"),
          color: Colors.white,
          sidesColor: Colors.black,
          readOnly: false,
        ),

        const SizedBox(
          height: 15,
        ),

        // password field
        MyFild(
          suffixIcon: IconButton(
            icon: Icon(isPasswordVisible1
                ? Icons.visibility_off
                : Icons.visibility),
            onPressed: () {
              setState(() {
                isPasswordVisible1 = !isPasswordVisible1;
              });
            },
          ),
          leftPadding: 20.0,
          rightPadding: 20.0,
          contorller: widget.passwordController,
          hintText: "كلمة المرور",
          obscure: true,
          lable: const Text("كلمة المرور"),
          color: Colors.white,
          sidesColor: Colors.black,
          readOnly: false,
          maxLine: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SendEmailForForgetPassword()));
                },
                child: Text(
                  "نسيت كلمة المرور؟",
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
            print(widget.usernameController.text);
            print(widget.passwordController.text);
            Navigator.of(context).push(MaterialPageRoute(

                builder: (context) => LogInApi(
                    passwordController: widget.passwordController,
                    usernameController: widget.usernameController)));
          },
          style: LogInStyle.buttonStyle(),
          child: Text(
            "تسجيل دخول",
            style: LogInStyle.logInButtonTextStyle(),
          ),
        ),
      ])),
    );
  }
}
