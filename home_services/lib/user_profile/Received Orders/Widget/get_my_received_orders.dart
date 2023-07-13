import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/Received%20Orders/Screen/my_received_orders.dart';
import 'package:home_services/user_profile/Received%20Orders/Screen/my_underway_order.dart';

// ignore: must_be_immutable
class GetMyReceivedOrder extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  var formList;
  bool isItUnderWay;
  GetMyReceivedOrder({Key? key,required this.user,this.formList,required this.isItUnderWay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future: ob.receivedOrder(user) ,
        builder: (context,AsyncSnapshot<List<Order?>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              return (isItUnderWay == false)?MyReceivedOrders(
                user: user,
                orders: snapshot.data!,
              ):MyUnderwayOrders(
                user: user,
                orders: snapshot.data!,
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
