// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Screen/services.dart';
import 'package:home_services/search/Api/search_api.dart';
import 'package:tuple/tuple.dart';

// ignore: must_be_immutable
class GetServiceNameSearchResult extends StatelessWidget {
  var user;
  TextEditingController titleController;
  GetServiceNameSearchResult({Key? key,required this.user,required this.titleController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchApi ob = SearchApi();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: ob.titleSearch(titleController),
          builder: (context,AsyncSnapshot<Tuple2<bool,List>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            } else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!.item1 == true){
                return Services(services: snapshot.data!.item2, user: user);
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
    );
  }
}
