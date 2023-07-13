// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';

// ignore: must_be_immutable
class SendUserRate extends StatelessWidget {
  int deadLine,quality,ethical,orderId;
  TextEditingController comment;
  var user;
  SendUserRate({Key? key,required this.orderId,required this.ethical,required this.deadLine,required this.quality,required this.comment,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.sendUserComment(user, orderId, ethical, deadLine, quality, comment),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isEmpty){
              return AlertDialog(
                title: const Text("تم إرسال النعليق بنجاح"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetCategoriesList(user: user, op: true)));
                  }, child: const Text("تأكيد"))
                ],
              );
            } else {
              return  AlertDialog(
                title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("تأكيد"))
                ],
              );
            }
          } else {
            return AlertDialog(
              title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("تأكيد"))
              ],
            );
          }
        },
      ),
    );
  }
}
