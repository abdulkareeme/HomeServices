import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Screen/user_options_for_service.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/list_my_services/Screen/seller_details_page.dart';
// ignore: must_be_immutable
class FetchServiceDetails extends StatelessWidget {
  int id;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  bool userSellerCase;
  FetchServiceDetails({
    required this.id,
    required this.userSellerCase,
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
              return  AlertDialog(
                title: const Text("حدث مشكلة أثناء الاتصال, الرجاء المحاولة لاحقا"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text("تأكيد"))
                ],
              );
            } else {
              return (userSellerCase == false) ? SellerServiceDetails(
                service: snapshot.data![0],
                user: user,
              ) : UserOptionForService(
                service: snapshot.data![0],
                user: user,
              );
            }
          } else {
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
