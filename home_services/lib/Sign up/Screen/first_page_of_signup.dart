import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:home_services/Animation/animation.dart';
import 'package:home_services/Sign%20up/Screen/second_page_of_signup.dart';
import 'package:home_services/my_field.dart';
import 'dart:ui' as ui;
import 'package:home_services/style/first_signup_page_style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FirstPageOfSignUp extends StatefulWidget {
  List areaList;

  FirstPageOfSignUp({required this.areaList, super.key});

  @override
  State<StatefulWidget> createState() => _FirstPageOfSignUpState();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  String areaError = "", genderError = "", modeError = "";
}

class _FirstPageOfSignUpState extends State<FirstPageOfSignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? gender;
  String? mode;
  String? area = "المنطقة";

  bool formState() {
    var ok = formKey.currentState;
    return ok!.validate();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body: Stack(children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.darken),
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
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height1 / 18,
                  ),
                  const Image(image:AssetImage("images/logo.png"),width: 280,),
                  const Padding(
                    padding:  EdgeInsets.only(right: 0),
                    child:  Text("إنشاء حساب جديد ",style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(
                    height: height1 / 20,
                  ),
                  // first name field
                  MyFild(
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    errorText: "",
                    contorller: widget.firstnameController,
                    hintText: "الاسم",
                    obscure: false,
                    lable: const Text("الاسم"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_) {
                      if (widget.firstnameController.text.isEmpty) {
                        return "required";
                      } else {
                        return null;
                      }
                    },
                    readOnly: false,
                    //autoValidateMode: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  // last name field
                  MyFild(
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    errorText: "",
                    contorller: widget.lastnameController,
                    hintText: "اسم العائلة",
                    obscure: false,
                    lable: const Text("اسم العائلة"),
                    color: Colors.white,
                    sidesColor: Colors.black,
                    val: (_) {
                      if (widget.lastnameController.text.isEmpty) {
                        return "required";
                      } else {
                        return null;
                      }
                    },
                    readOnly: false,
                    //autoValidateMode: true,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  // birth date field

                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.white60),
                      decoration: const InputDecoration(
                          hintText: "تاريخ الميلاد",
                          hintStyle: TextStyle(color: Colors.white60),
                          enabled: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white30)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white30))),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2030))
                            .then((value) {
                          setState(() {
                            widget.dateController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(value!)
                                    .toString();
                          });
                        });
                      },
                      controller: widget.dateController,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // area selection
                  Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.black,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white30,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white30,
                            ))),
                        style: const TextStyle(
                          color: Colors.white60,
                        ),
                        items: widget.areaList
                            .map((e) => DropdownMenuItem(
                                value: e[0],
                                child: Text(
                                  "${e[1]}",
                                  textDirection: ui.TextDirection.rtl,
                                )))
                            .toList(),
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            area = val.toString();
                          });
                        },
                        hint: const Text(
                          'المحافظة',
                          style: TextStyle(color: Colors.white60),
                        ),
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
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      children: [
                        const Text(
                          "نوع الحساب :",
                          style: TextStyle(color: Colors.white60, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text("بائع",
                            style: TextStyle(color: Colors.white60)),
                        Radio(
                          activeColor: Colors.white,
                          focusColor: Colors.white,
                          value: "seller",
                          groupValue: mode,
                          onChanged: (val) {
                            setState(() {
                              mode = val.toString();
                            });
                          },
                        ),

                        const Text("مستخدم",
                            style: TextStyle(color: Colors.white60)),
                        //const SizedBox(width: 2,),
                        Radio(
                            activeColor: Colors.white,
                            focusColor: Colors.white,
                            value: "client",
                            groupValue: mode,
                            onChanged: (val) {
                              setState(() {
                                mode = val.toString();
                              });
                            },

                        )
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
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      children: [
                        const Text("الجنس :",
                            style:
                                TextStyle(color: Colors.white60, fontSize: 20)),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text("ذكر",
                            style: TextStyle(color: Colors.white60)),
                        Radio(
                          activeColor: Colors.white,
                          focusColor: Colors.white,
                          value: "Male",
                          groupValue: gender,
                          onChanged: (val1) {
                            setState(() {
                              gender = val1.toString();
                            });
                          },
                        ),

                        const Text("أنثى",
                            style: TextStyle(color: Colors.white60)),
                        //const SizedBox(width: 2,),
                        Radio(
                            activeColor: Colors.white,
                            focusColor: Colors.white,
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
                    widget.genderError,
                    style: const TextStyle(color: Colors.red),
                  ),
                  //const SizedBox(height: 9,),
                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 35),
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
                                setState(() {
                                  widget.genderError = "";
                                  widget.modeError = "";
                                  widget.areaError = "";
                                });
                                Navigator.of(context).push(SlideRight(
                                    page: SecondPageOfSignUp(
                                  birthDateController: widget.dateController,
                                  area: area,
                                  firstnameController:
                                      widget.firstnameController,
                                  lastnameController: widget.lastnameController,
                                  gender: gender,
                                  mode: mode,
                                )));
                              } else {
                                if (gender == null) {
                                  setState(() {
                                    widget.genderError = "required";
                                  });
                                } else {
                                  widget.genderError = "";
                                }
                                if (mode == null) {
                                  setState(() {
                                    widget.modeError = "required";
                                  });
                                } else {
                                  widget.modeError = "";
                                }
                                if (area == "المنطقة") {
                                  setState(() {
                                    widget.areaError = "required";
                                  });
                                } else {
                                  widget.areaError = "";
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
      ),
    ));
  }
}
