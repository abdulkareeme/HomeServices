import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/home_page.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:quickalert/quickalert.dart';

// ignore: must_be_immutable
class DeleteService extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ServiceDetails service;
  DeleteService({required this.user, required this.service,super.key});
  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return(
      SafeArea(
        child: Scaffold(
          body:FutureBuilder(
            future: ob.deleteService(service.id,user),
            builder: (context ,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              } else if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isEmpty){
                  /*QuickAlert.show(
                      context: context,
                      type:QuickAlertType.success,
                      title: "تم حذف الخدمة بنجاح",
                      text: "",
                      confirmBtnText: "تأكيد",
                      onConfirmBtnTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage(user: user)));
                      }
                  );*/
                  return Container();
                } else {
                  /*QuickAlert.show(
                      context: context,
                      type:QuickAlertType.error,
                      title: "حدث خطأ اثناء الاتصال,الرجاء المحاولة لاحقا",
                      text: "",
                      confirmBtnText: "تأكيد",
                      onConfirmBtnTap: (){
                        Navigator.of(context).pop();
                      }
                  );*/
                  return const Text("noooooooo");
                }
              } else {
                /*QuickAlert.show(
                    context: context,
                    type:QuickAlertType.error,
                    title: "حدث خطأ اثناء الاتصال,الرجاء المحاولة لاحقا",
                    text: "",
                    confirmBtnText: "تأكيد",
                    onConfirmBtnTap: (){
                      Navigator.of(context).pop();
                    }
                );*/
                return const Text("NOOOOOOOOO");
              }
            },
          ),
        ),
      )
    );
  }

}