import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
class PostOrder extends StatelessWidget {
  var user,serviceId,formAnswer;
  PostOrder({Key? key,required this.formAnswer,required this.serviceId,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.postOrder(serviceId, user, formAnswer),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              return AlertDialog(
                title: const Text("تم طلب الخدمة بنجاح"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
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
