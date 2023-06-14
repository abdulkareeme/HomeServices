import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/user_profile/update_profile/set_user_new_info.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
// ignore: must_be_immutable
class UpdateUserInfo extends StatefulWidget {
  var userInfo;
  UpdateUserInfo({
    required this.userInfo,
    super.key,
  }) ;

  @override
  State<StatefulWidget> createState() => _UpdateUserInfoState();
  TextEditingController firstNameController = TextEditingController(
    text: "عبد الهادي"
  );
  TextEditingController lastNameController = TextEditingController(
    text: "ابو الشامات"
  );
  TextEditingController dateController = TextEditingController(
    text: "2001-02-15"
  );
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFild(
                contorller: widget.firstNameController,
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
                contorller: widget.lastNameController,
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
                        widget.dateController.text = DateFormat('yyyy-MM-dd')
                            .format(value!)
                            .toString();
                      });
                    });
                  },
                  controller: widget.dateController,
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  readOnly: false,
                  decoration: const InputDecoration(hintText: "Birth date"),
                  onTap: () {},

                ),
              ),


              ElevatedButton(onPressed: (){
                var newList = [
                  widget.firstNameController,
                  widget.lastNameController,
                  widget.dateController,
                  "aaaa",
                  1,
                  widget.userInfo[4],
                ];
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
