import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Widget/third_page_of_singup.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';

// ignore: must_be_immutable
class SecondPageOfSignUp extends StatefulWidget {
  SecondPageOfSignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondPageOfSignUpState();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String passwordError = "";
  String confirmPasswordError = "";
  String emailError = "";
}

class _SecondPageOfSignUpState extends State<SecondPageOfSignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              color: Colors.red,
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  // email field
                  MyFild(
                    errorText: widget.emailError,
                    contorller: widget.emailController,
                    hintText: "email",
                    obscure: false,
                    lable: const Text("Email"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),

                  // password field
                  MyFild(
                    errorText: widget.passwordError,
                    contorller: widget.passwordController,
                    hintText: "password",
                    obscure: false,
                    lable: const Text("Password"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),

                  // confirm password field
                  MyFild(
                    errorText: widget.confirmPasswordError,
                    contorller: widget.confirmPasswordController,
                    hintText: "password",
                    obscure: false,
                    lable: const Text("Confirm Password"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style:FirstSignupPageStyle.nextButtonStyle(),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Back", style: FirstSignupPageStyle
                                .nextTextStyle(),)),
                        const SizedBox(width: 10,)
                        , ElevatedButton(
                            style: FirstSignupPageStyle.nextButtonStyle(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>ThirdPageOfSignUp()));
                            },
                            child: Text("Next", style: FirstSignupPageStyle
                                .nextTextStyle(),))
                      ],
                    ),
                ],
              ),
            ),
          ]),
        ));
  }
}
