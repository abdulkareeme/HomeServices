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
  TextEditingController birthdateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
}

class _FirstPageOfSignUpState extends State<FirstPageOfSignUp> {
  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    String? gender;
    String? mode;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.yellow,
        ),
        Form(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height1 / 4,
                ),
                // first name field
                MyFild(
                  errorText: "",
                  contorller: widget.firstnameController,
                  hintText: "First Name",
                  obscure: false,
                  lable: const Text("First Name"),
                  color: Colors.white,
                  sidesColor: Colors.black,
                ),

                // last name field
                MyFild(
                  errorText: "",
                  contorller: widget.lastnameController,
                  hintText: "Last Name",
                  obscure: false,
                  lable: const Text("Last Name"),
                  color: Colors.white,
                  sidesColor: Colors.black,
                ),

                // birth date field
                MyFild(
                  errorText: "",
                  contorller: widget.birthdateController,
                  hintText: "Birth Date",
                  obscure: false,
                  lable: const Text("Birth Date"),
                  color: Colors.white,
                  sidesColor: Colors.black,
                ),

                // area field
                MyFild(
                  errorText: "",
                  contorller: widget.areaController,
                  hintText: "Area",
                  obscure: false,
                  lable: const Text("Area"),
                  color: Colors.white,
                  sidesColor: Colors.black,
                ),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      const Text("Account Type :"),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Seller"),
                      Radio(
                        value: "Seller",
                        groupValue: mode,
                        onChanged: (val) {
                          setState(() {
                            mode = val.toString();
                          });
                        },
                      ),

                      const Text("Client"),
                      //const SizedBox(width: 2,),
                      Radio(
                          value: "Client",
                          groupValue: mode,
                          onChanged: (val1) {
                            setState(() {
                              mode = val1.toString();
                            });
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      const Text("Gender :"),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Male"),
                      Radio(
                        value: "Male",
                        groupValue: gender,
                        onChanged: (val) {
                          setState(() {
                            gender = val.toString();
                          });
                        },
                      ),

                      const Text("Female"),
                      //const SizedBox(width: 2,),
                      Radio(
                          value: "Female",
                          groupValue: gender,
                          onChanged: (val1) {
                            setState(() {
                              gender = val1.toString();
                            });
                          })
                    ],
                  ),
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
                            Navigator.of(context)
                                .push(SlideRight(page: SecondPageOfSignUp()));
                          },
                          child: Text(
                            "التالي",
                            style: FirstSignupPageStyle.nextTextStyle(),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
