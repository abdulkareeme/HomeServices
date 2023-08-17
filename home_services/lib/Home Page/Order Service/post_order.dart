import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';
import 'package:tuple/tuple.dart';
// ignore: must_be_immutable
class PostOrder extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user,serviceId,formAnswer;
  PostOrder({Key? key,required this.formAnswer,required this.serviceId,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.postOrder(serviceId, user, formAnswer),
        builder: (context,AsyncSnapshot<Tuple2<bool,List?>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.item1 == true){
              return AlertDialog(
                title: const Text("تم طلب الخدمة بنجاح"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetCategoriesList(user: user, op: true)));
                  }, child: const Text("تأكيد"))
                ],
              );
            } else if(snapshot.data!.item1 == false && snapshot.data!.item2!.isNotEmpty){
              return  AlertDialog(
                title: Text(snapshot.data!.item2![0].toString()),
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
