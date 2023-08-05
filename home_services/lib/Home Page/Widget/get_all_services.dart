import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
import 'package:home_services/Home%20Page/Screen/home_page.dart';
import 'package:home_services/Home%20Page/Widget/get_seller_balance.dart';
import 'package:tuple/tuple.dart';


class GetAllServices extends StatelessWidget {
  var user,categoryList;
  GetAllServices({Key? key,required this.user,required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: ob.getAllServices(),
          builder: (context,AsyncSnapshot<Tuple2<bool,List?>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            } else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!.item1 == true){
                return GetSellerBalance(
                  user: user,
                  categoryList: categoryList,
                  services: snapshot.data!.item2,
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
