import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';

// ignore: must_be_immutable
class CreateService extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var titleController , descriptionController, priceController, type,areaList,formList,user;
  CreateService({
    required this.areaList,
    required this.priceController,
    required this.type,
    required this.descriptionController,
    required this.titleController,
    required this.formList,
    required this.user,
    super.key
  });
  ProfileApi ob = ProfileApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ob.createServeice(titleController, descriptionController, priceController, type, areaList, formList, user),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return  AlertDialog(
                title: const Text("حدث مشكلة اثناء الاتصال"),
                content: const Text("الرجاء المحاولة لاحقا"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("تأكيد"))
                ],
              );
            } else {
              return AlertDialog(
                title: Text("تم إنشاء خدمة ${utf8.decode(snapshot.data![0].toString().codeUnits)} بنجاح  "),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetCategoriesList(user: user, op: true)));
                  }, child: const Text("تأكيد"))
                ],
              );
            }
          } else {
            return  AlertDialog(
              title: const Text("حدث مشكلة اثناء الاتصال"),
              content: const Text("الرجاء المحاولة لاحقا"),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("تأكيد"))
              ],
            );
          }
        },
      ) ,
    );
  }


}