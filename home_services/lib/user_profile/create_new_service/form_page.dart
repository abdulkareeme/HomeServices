import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

class ServiceForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: SingleChildScrollView(
         child: Form(
           child: Column(
             children: [

             ],
           ),
         ),
       ),
      ),
    );
  }


}