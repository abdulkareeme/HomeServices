import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/Log%20out/Api/Log_out_Api.dart';


// ignore: must_be_immutable
class LogOut extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  LogOut({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogOutApi ob = LogOutApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.logOute(user),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data!.isNotEmpty){
              return AlertDialog(
                title: const Text("تم تسجيل الخروج بنجاح"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn(error: '')));
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
