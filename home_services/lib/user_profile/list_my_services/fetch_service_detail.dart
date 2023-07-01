import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/list_my_services/seller_details_page.dart';
// ignore: must_be_immutable
class FetchServiceDetails extends StatelessWidget {
  int id;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  FetchServiceDetails({
    required this.id,
    this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return(
      FutureBuilder(
        future: ob.myServiceDetail(id),
        builder: (context,AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done&& snapshot.hasData){
            if(snapshot.data!.isEmpty){
              print("ohhhhhhhhhhhhh");
              return  AlertDialog(
                title: const Text("حدث مشكلة أثناء الاتصال, الرجاء المحاولة لاحقا"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("تأكيد"))
                ],
              );
            } else {
              return SellerServiceDetails(
                service: snapshot.data![0],
                user: user,
              );
            }
          } else {
            print("im here");
            return  AlertDialog(
              title: const Text("حدث مشكلة أثناء الاتصال, الرجاء المحاولة لاحقا"),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("تأكيد"))
              ],
            );
          }

        },
      )
    );
  }
}
