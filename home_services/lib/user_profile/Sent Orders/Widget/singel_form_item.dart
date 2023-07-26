import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';


// ignore: must_be_immutable
class SingleFormItem extends StatelessWidget {
  var title,controller;
  SingleFormItem({Key? key,required this.title,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),),
        const SizedBox(height: 7,),
        MyFild(
          contorller: controller,
          hintText: "",
          obscure: false,
          lable: null,
          readOnly: true,
          rightPadding: 20.0,
          leftPadding: 20.0,
          color: Colors.white,
          sidesColor: Colors.black38
        )
      ],
    );
  }
}
