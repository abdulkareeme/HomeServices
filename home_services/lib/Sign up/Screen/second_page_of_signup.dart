import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Widget/sign_up_page.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';
// ignore: must_be_immutable
class SecondPageOfSignUp extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var firstnameController, lastnameController, area, birthDateController, gender, mode;

  SecondPageOfSignUp({
    required this.firstnameController,
    required this.lastnameController,
    required this.birthDateController,
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

  bool formState() {
    var ok = formKey.currentState;
    return ok!.validate();
  }
  bool isPasswordVisible = false;
  bool isPasswordVisible1 = false;
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
      body: Stack(children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
            child: Container(
              height: height1,
              width: width1,
              child: const Image(
                image: AssetImage('images/signup1.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height1 / 18,
                  ),
                  const Image(image:AssetImage("images/logo.png"),width: 280,),
                  const Padding(
                    padding:  EdgeInsets.only(right: 25),
                    child:  Text("إنشاء حساب جديد ",style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(
                    height: height1 / 20,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // email field
                  MyFild(
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    errorText: widget.emailError,
                    contorller: widget.emailController,
                    hintText: "البريد الالكتروني",
                    obscure: false,
                    lable: const Text("البريد الالكتروني"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_) {
                      if (widget.emailController.text.isEmpty) {
                        return "required";
                      } else {
                        if (EmailValidator.validate(widget.emailController.text)) {
                          return null;
                        } else {
                          return "invalid email";
                        }
                      }
                    },
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 6,
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
                    errorText: widget.passwordError,
                    contorller: widget.passwordController,
                    hintText: "كلمة المرور",
                    obscure: !isPasswordVisible1,
                    lable: const Text("كلمة المرور"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_) {
                      if (widget.passwordController.text.length < 8) {
                        return "password should be as least 8 characters";
                      } else {
                        return null;
                      }
                    },
                    maxLine: 1,
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  // confirm password field
                  MyFild(
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    maxLine: 1,
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    errorText: widget.confirmPasswordError,
                    contorller: widget.confirmPasswordController,
                    hintText: "تأكيد كلمة المرور",
                    obscure: !isPasswordVisible,
                    lable: const Text("تأكيد كلمة المرور"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_) {
                      if (widget.confirmPasswordController.text !=
                          widget.passwordController.text) {
                        return "password not matching";
                      } else {
                        return null;
                      }
                    },
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: FirstSignupPageStyle.nextButtonStyle(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "الرجوع",
                            style: FirstSignupPageStyle.nextTextStyle(),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: FirstSignupPageStyle.nextButtonStyle(),
                          onPressed: () {
                            for(int i=0;i<widget.emailController.text.length;i++){
                              if(widget.emailController.text[i]!= '@') {
                                widget.username+=widget.emailController.text[i];
                              } else {
                                break;
                              }
                            }
                            if (formState()) {
                              print(widget.username);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage(
                                  firstnameController: widget.firstnameController,
                                  lastnameController: widget.lastnameController,
                                  area: widget.area,
                                  gender: widget.gender,
                                  mode: widget.mode,
                                  username: widget.username,
                                  emailController: widget.emailController,
                                  passwordController: widget.passwordController,
                                  confirmPasswordError: widget.confirmPasswordError,
                                  passwordError: widget.passwordError,
                                  emailError:widget.emailError,
                                  birthdatecontroller: widget.birthDateController,
                                  confirmaPasswordController: widget.confirmPasswordController)));
                            }
                          },
                          child: Text(
                            "الانضمام لمنزلي",
                            style: FirstSignupPageStyle.nextTextStyle(),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
      ]),
    ),
        ));
  }
}
