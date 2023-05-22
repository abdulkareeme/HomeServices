import 'package:flutter/material.dart';
import 'package:home_services/Animation/animation.dart';
import 'package:home_services/Sign%20up/Widget/second_page_of_signup.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';

// ignore: must_be_immutable
class FirstPageOfSignUp extends StatefulWidget {
  FirstPageOfSignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstPageOfSignUpState();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  String firstnameError = "";
  String lastnameError = "";
  String usernameError = "";
}

class _FirstPageOfSignUpState extends State<FirstPageOfSignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              color: Colors.yellow,
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  // first name field
                  MyFild(
                    errorText: widget.firstnameError,
                    contorller: widget.firstnameController,
                    hintText: "First Name",
                    obscure: false,
                    lable: const Text("First Name"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),

                  // last name field
                  MyFild(
                    errorText: widget.lastnameError,
                    contorller: widget.lastnameController,
                    hintText: "Last Name",
                    obscure: false,
                    lable: const Text("Last Name"),
                    color: Colors.white,
                    sidesColor: Colors.black,
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
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: FirstSignupPageStyle.nextButtonStyle(),
                            onPressed: () {
                              Navigator.of(context).push(SlideRight(page: SecondPageOfSignUp()) );
                            },
                            child: Text("التالي", style: FirstSignupPageStyle
                                .nextTextStyle(),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
