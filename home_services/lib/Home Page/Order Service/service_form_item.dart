import 'package:flutter/material.dart';

import '../../my_field.dart';
import '../../my_int_field.dart';


// ignore: must_be_immutable
class ServiceItemForm extends StatelessWidget {
  int id;
  String title,type,note;
  var op;
  bool inFirstFour;
  ServiceItemForm({this.op,required this.id,required this.title,required this.type,required this.note, required this.inFirstFour,super.key});
  TextEditingController controller = TextEditingController();

  TextEditingController getController(){
    return controller;
  }
  int geId(){
    return id;
  }
  String getNote(){
    return note;
  }
  String getType(){
    return type;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
              ],
            ),
          (type == "text")?
          MyFild(
              contorller: controller,
              hintText: title,
              obscure: false,
              lable: null,
              errorText: "",
              readOnly: false,
              rightPadding: 20.0,
              leftPadding: 20.0,
              color: Colors.white,
              sidesColor: Colors.black,
              val:(inFirstFour == true )? op : (_){
                if(controller.text.isEmpty){
                  return "required";
                } else {
                  return null;
                }
              },
          ) :
          MyINTField(
              keyboardType: TextInputType.number,
              contorller: controller,
              hintText: title,
              obscure: false,
              lable: null,
              errorText: "",
              val: (inFirstFour == true )? op : (_){
                if(controller.text.isEmpty){
                  return "required";
                } else {
                  return null;
                }
              },
              readOnly: false,
              color: Colors.white,
              sidesColor: Colors.black,
          ),
          const SizedBox(height: 6,),
          Text(note),
        ],
      ),
    );
  }
}

