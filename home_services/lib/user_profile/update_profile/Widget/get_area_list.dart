import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
import 'package:home_services/user_profile/update_profile/Screen/update_user_info.dart';

// ignore: must_be_immutable
class GetAreaList1 extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  GetAreaList1({
    required this.user,
    super.key,
});
  @override
  Widget build(BuildContext context) {
    SignUpApi ob = SignUpApi();
    return FutureBuilder(
      future: ob.getAreaList(),
      builder: (context,AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          if(snapshot.data!.isEmpty){
            return AlertDialog(
              content: const Text("حدث خطأ اثناء الاتصال, الرجاء اعادة المحاولة لاحقا"),
              actions: [
                ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                }, child: const Text("OK"))
              ],
            );
          } else {
            return UpdateUserInfo(user: user,areaList: snapshot.data!,);
          }
        } else {
          return AlertDialog(
            content: const Text("حدث خطأ اثناء الاتصال, الرجاء اعادة المحاولة لاحقا"),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("OK"))
            ],
          );
        }
      },
    );

  }


}