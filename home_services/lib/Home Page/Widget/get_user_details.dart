import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Api/home_page_api.dart';
import 'package:home_services/Home%20Page/Widget/user_details.dart';


class GetUserDetails extends StatelessWidget {
  String username;
  GetUserDetails({Key? key,required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageApi ob = HomePageApi();
    return Scaffold(
      body: FutureBuilder(
        future: ob.getUserDetails(username),
        builder: (context, AsyncSnapshot<List?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else {
            if(snapshot.connectionState == ConnectionState.done){
             /* print(snapshot.data![0]);
              print(snapshot.data![1]);*/
              return UserDetails(user: snapshot.data![0],service:snapshot.data![1],);
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
          }
        },
      ),
    );
  }
}