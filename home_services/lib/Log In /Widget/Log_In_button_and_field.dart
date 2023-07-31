import 'package:email_validator/email_validator.dart';
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
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible1 = true;
  LogOutApi op = LogOutApi();
  bool formState(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
          errorText: "",
          contorller: usernameController,
          hintText: "البريد الالكتروني",
          obscure: false,
          lable: const Text("البريد الالكتروني"),
          color: Colors.white,
          sidesColor: Colors.black,
          readOnly: false,
          val: (_){
            if(usernameController.text.isNotEmpty){
              if(EmailValidator.validate(usernameController.text)){
                return null;
              } else {
                return "invalid email";
              }
            } else {
              return "required";
            }
          },
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
          errorText: "",
          leftPadding: 20.0,
          rightPadding: 20.0,
          contorller: passwordController,
          hintText: "كلمة المرور",
          obscure: isPasswordVisible1,
          lable: const Text("كلمة المرور"),
          color: Colors.white,
          sidesColor: Colors.black,
          readOnly: false,
          maxLine: 1,
          val: (_){
            if(passwordController.text.isEmpty){
              return "required";
            } else {
              return null;
            }
          },
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

            if(formState()){
              Navigator.of(context).pushReplacement(MaterialPageRoute(

                  builder: (context) => LogInApi(
                      passwordController: passwordController,
                      usernameController: usernameController)));
            }
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
