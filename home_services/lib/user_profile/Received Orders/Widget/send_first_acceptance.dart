import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/form.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/get_my_received_orders.dart';

class SendFirstAcceptance extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user,id;
  Order? order;
  SendFirstAcceptance({Key? key,required this.id,required this.user,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.firstAccept(id, user),
        builder: (context,AsyncSnapshot<List<Form1>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              order!.formList = snapshot.data!;
              return AlertDialog(
                title: const Text("تم قبول الخدمة"),
                content: const Text("امامك 15 دقيقة لرفض الطلب بعد مراجعة فورم الخدمة والا سيتم قبوله تلقائيا "),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetMyReceivedOrder(user: user,formList: snapshot.data,isItUnderWay: false,)));
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
