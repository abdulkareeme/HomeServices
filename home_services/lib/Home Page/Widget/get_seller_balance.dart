import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Screen/home_page.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:tuple/tuple.dart';

class GetSellerBalance extends StatelessWidget {
  var user,categoryList,services;
  GetSellerBalance({Key? key,required this.services,required this.categoryList,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: ob.getUserBalance(user),
          builder: (context,AsyncSnapshot<Tuple2<bool,int>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            } else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!.item1 == true){
                return HomePage(
                  user: user,
                  category: categoryList,
                  services: services,
                  sellerBalance: snapshot.data!.item2,
                );
              } else {
                return AlertDialog(
                  title: const Text("حدث مشكلة أثناء الاتصال, الرجاء المحاولة لاحقا"),
                  actions: [
                    ElevatedButton(

                        onPressed: (){
                          Navigator.of(context).canPop();
                        },
                        child: const Text("تأكيد"))
                  ],
                );
              }
            } else {
              return AlertDialog(
                title: const Text("حدث مشكلة أثناء الاتصال, الرجاء المحاولة لاحقا"),
                actions: [
                  ElevatedButton(

                      onPressed: (){
                        Navigator.of(context).canPop();
                      },
                      child: const Text("تأكيد"))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
