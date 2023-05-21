import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';

// ignore: must_be_immutable
class ThirdPageOfSignUp extends StatefulWidget {
  ThirdPageOfSignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThirdPageOfSignUpState();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String passwordError = "";
  String emailError = "";
}

class _ThirdPageOfSignUpState extends State<ThirdPageOfSignUp> {
  String? gender;
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
                  // email field
                  MyFild(
                    errorText: widget.emailError,
                    contorller: widget.emailController,
                    hintText: "Birth Date",
                    obscure: false,
                    lable: const Text("Birth Date"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),

                  // password field
                  MyFild(
                    errorText: widget.passwordError,
                    contorller: widget.passwordController,
                    hintText: "Area",
                    obscure: false,
                    lable: const Text("Area"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),

                  // confirm password field
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Column(
                          children: const[
                             Text("Gender :"),
                            Text("    ")
                          ],
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text("Male"),
                                Radio(value: "Male", groupValue: gender, onChanged:(val){
                                  setState(() {
                                    gender = val.toString();
                                  });
                                })
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Female"),
                                Radio(value: "Female", groupValue: gender, onChanged:(val){
                                  setState(() {
                                    gender = val.toString();
                                  });
                                })
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
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
                            /*Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>))*/
                          },
                          child: Text("Sign up", style: FirstSignupPageStyle
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
