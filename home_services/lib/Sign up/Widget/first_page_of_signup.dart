import 'package:flutter/material.dart';
import 'package:home_services/Animation/animation.dart';
import 'package:home_services/Sign%20up/Widget/second_page_of_signup.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/style/first_signup_page_style.dart';

// ignore: must_be_immutable
class FirstPageOfSignUp extends StatefulWidget {
  List areaList;

  FirstPageOfSignUp({required this.areaList, super.key});

  @override
  State<StatefulWidget> createState() => _FirstPageOfSignUpState();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  String areaError = "", genderError = "", modeError = "";
}

class _FirstPageOfSignUpState extends State<FirstPageOfSignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? gender;
  String? mode;
  String area = "Area";

  bool formState() {
    var ok = formKey.currentState;
    return ok!.validate();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.yellow,
        ),
        Form(
          key: formKey,
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
                  val: (_) {
                    if (widget.firstnameController.text.isEmpty) {
                      return "required";
                    } else {
                      return null;
                    }
                  },
                  //autoValidateMode: true,
                ),
                const SizedBox(
                  height: 5,
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
                  val: (_) {
                    if (widget.lastnameController.text.isEmpty) {
                      return "required";
                    } else {
                      return null;
                    }
                  },
                  //autoValidateMode: true,
                ),
                const SizedBox(
                  height: 5,
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
                const SizedBox(
                  height: 5,
                ),
                // area selection
                Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: DropdownButtonFormField(
                      items: widget.areaList
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text("$e")))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          area = val.toString();
                        });
                      },
                      hint: Text(area),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.areaError,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 16,
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
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.modeError,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 9,
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
                  height: 6,
                ),
                Text(
                  widget.modeError,
                  style: const TextStyle(color: Colors.red),
                ),
                //const SizedBox(height: 9,),
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
                            if (formState() &&
                                gender != null &&
                                mode != null &&
                                area != "Area") {
                              Navigator.of(context).push(SlideRight(
                                  page: SecondPageOfSignUp(
                                area: area,
                                firstnameController: widget.firstnameController,
                                lastnameController: widget.lastnameController,
                                gender: gender,
                                mode: mode,
                              )));
                            } else {
                              if (gender == null) {
                                setState(() {
                                  widget.genderError = "required";
                                });
                              }
                              if (mode == null) {
                                setState(() {
                                  widget.modeError = "required";
                                });
                              }
                              if (area == "Area") {
                                setState(() {
                                  widget.areaError = "required";
                                });
                              }
                            }
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
