import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

class UpdateUserInfo extends StatefulWidget {

  UpdateUserInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdateUserInfoState();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection:TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              MyFild(
                  contorller: null,
                  hintText: "إسم المستخدم",
                  obscure: false,
                  lable: "إسم المستخد ",
                  readOnly: false
              ),

              const SizedBox(
                height: 6,
              ),

              MyFild(
                  contorller: null ,
                  hintText: "اسم العائلة",
                  obscure: false,
                  lable: "اسم العائلة",
                  readOnly: false,

              ),
              const SizedBox(height: 6,),

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
                          for(int i=0;i<9;i++){
                            op+=value.toString()[i];
                          }
                      setState(() {
                        widget.dateController.text = op.toString();
                      });
                    });
                  },
                  controller: widget.dateController,
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
