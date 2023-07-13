import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/user_profile/update_profile/Widget/set_user_new_info.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class UpdateUserInfo extends StatefulWidget {
  var user;
  List areaList;
  UpdateUserInfo({
    required this.user,
    required this.areaList,
    super.key,
  }) ;
  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
  String? area = "";
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController(
      text: widget.user.firstName,
    );
    TextEditingController lastNameController = TextEditingController(
        text: widget.user.lastName,
    );
    TextEditingController dateController = TextEditingController(
        text: widget.user.birthDate
    );
    TextEditingController bioController = TextEditingController(
      text: widget.user.bio
    );
    return SafeArea(
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            body: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyFild(
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    contorller: firstNameController,
                    hintText: "إسم المستخدم",
                    obscure: false,
                    lable: const Text("إسم المستخدم"),
                    readOnly: false,
                    color: Colors.white70,
                    sidesColor: Colors.black,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  MyFild(
                    leftPadding: 20.0,
                    rightPadding: 20.0,
                    contorller: lastNameController,
                    hintText: "اسم العائلة",
                    obscure: false,
                    lable: const Text("اسم العائلة"),
                    readOnly: false,
                    color: Colors.white70,
                    sidesColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(hintText: "Birth date"),
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2030))
                            .then((value) {
                          setState(() {
                            dateController.text = DateFormat('yyyy-MM-dd')
                                .format(value!)
                                .toString();
                          });
                        });
                      },
                      controller: dateController,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ))),
                        style: const TextStyle(
                          color: Colors.black,
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
                            widget.area = val.toString();
                          });
                        },
                        hint: const Text(
                          'المحافظة',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      controller: bioController,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: 400,

                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    var newList = [
                      firstNameController,
                      lastNameController,
                      dateController,
                      bioController,
                      widget.area,
                      widget.user.token,
                    ];
                    print(newList);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SetUserNewData(userNewData: newList)));
                  }, child: const Text("تعديل"))
                  // area field editing
                ],
              ),
            ),
          ),
        ));
  }
}
