import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/list_my_services/Screen/my_services_page.dart';

// ignore: must_be_immutable
class MyServiceFetchData extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  MyServiceFetchData({
    required this.user,
    super.key
}) ;

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return(
      SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: ob.listMyServices(user),
            builder: (context,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return MyServices(services: snapshot.data!,user: user,);
              } else {
                return  AlertDialog(
                  title:const Text("حدث مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
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
      )
    );
  }

}