import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';


class SendFinishAnswer extends StatelessWidget {
  var user,id;
  SendFinishAnswer({Key? key,required this.id,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.finishOrder(id, user),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              return AlertDialog(
                title: const Text("تم إنهاء الخدمة بنجاح"),
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
