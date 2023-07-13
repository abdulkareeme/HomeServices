import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';

// ignore: must_be_immutable
class DeleteService extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ServiceDetails service;
  DeleteService({required this.user, required this.service,super.key});
  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    String op = service.title;
    return(
      SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body:FutureBuilder(
              future: ob.deleteService(service.id,user),
              builder: (context ,AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                } else if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.data!.isEmpty){
                    return AlertDialog(
                      title: Text(" تم حذف خدمة $opبنجاح "),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetCategoriesList(user: user, op: true)));
                        }, child: const Text("تأكيد"))
                      ],
                    );
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
          ),
        ),
      )
    );
  }

}