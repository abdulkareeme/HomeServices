import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Widget/third_page_of_singup.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';

import '../../Animation/animation.dart';

// ignore: must_be_immutable
class SecondPageOfSignUp extends StatefulWidget {
  var firstnameController,lastnameController,area,birthdatecontroller,gender,mode;
  SecondPageOfSignUp({
    required this.firstnameController,
    required this.lastnameController,
    required this.area,
    required this.gender,
    required this.mode,
    super.key,
});

  @override
  State<StatefulWidget> createState() => _SecondPageOfSignUpState();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String passwordError = "";
  String confirmPasswordError = "";
  String emailError = "";
  String username = "";
}

class _SecondPageOfSignUpState extends State<SecondPageOfSignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool formState(){
    var ok = formKey.currentState;
    return ok!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              color: Colors.deepPurple,
            ),
            Form(
              key: formKey,
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
                    val: (_){
                      if(widget.emailController.text.isEmpty){
                        return "required";
                      } else {
                        for(int i=0;i<widget.emailController.text.length;i++){
                          if(widget.emailController.text[i] != '@'){
                            widget.username+=widget.emailController.text[i];
                          }
                        }
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 6,),
                  // password field
                  MyFild(
                    errorText: widget.passwordError,
                    contorller: widget.passwordController,
                    hintText: "password",
                    obscure: false,
                    lable: const Text("Password"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_){
                      if(widget.passwordController.text.length < 8){
                        return "password should be as least 8 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 6,),
                  // confirm password field
                  MyFild(
                    errorText: widget.confirmPasswordError,
                    contorller: widget.confirmPasswordController,
                    hintText: "password",
                    obscure: false,
                    lable: const Text("Confirm Password"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_){
                      if(widget.confirmPasswordController.text != widget.passwordController.text){
                        return "password not matching";
                      } else {
                        return null;
                      }
                    },
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
                              if(formState()){
                              Navigator.of(context).push(SlideRight(page: ThirdPageOfSignUp()));
                              }
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
