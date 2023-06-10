import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

class UpdateUserInfo extends StatefulWidget {
  UpdateUserInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdateUserInfoState();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String name  = "عبد الهادي";
  String lastName = "ابو الشامات";
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {

  void intiState(){
    super.initState();
    setState(() {
      widget.firstNameController.text = widget.name;
      widget.lastNameController.text = widget.lastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
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
                      var op = "";
                      for (int i = 0; i < 9; i++) {
                        op += value.toString()[i];
                      }
                      setState(() {
                        widget.dateController.text = op.toString();
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
              // area field editing
            ],
          ),
        ),
      ),
    ));
  }
}
