import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
import 'package:home_services/Home%20Page/Order%20Service/order_service.dart';

class GetOrderedServiceForm extends StatelessWidget {
  int id;
  var user;
  GetOrderedServiceForm({Key? key,required this.id,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return Scaffold(
      body: FutureBuilder(
        future: ob.getOrderedServiceForm(id, user),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              print(snapshot.data);
              return OrderService(serviceForms: snapshot.data,user: user,serviceid: id,);
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
