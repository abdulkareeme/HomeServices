import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
import 'package:home_services/Home%20Page/Screen/services.dart';

// ignore: must_be_immutable
class GetThisCategoryServices extends StatelessWidget {
  var user;
  String categoryName;
  GetThisCategoryServices({Key? key,required this.user,required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return(
        SafeArea(
          child: Scaffold(
            body: FutureBuilder(
              future: ob.getThisCategoryServices(categoryName),
              builder: (context,AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  return Services(services:snapshot.data!,user: user,category: categoryName,);
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
