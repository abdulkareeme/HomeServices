import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/rating.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/rating/Screen/all_my_rating.dart';

// ignore: must_be_immutable
class GetMyAllRating extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  GetMyAllRating({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.getAllMyRating(user),
        builder: (context,AsyncSnapshot<List<HomeServiceRating>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
            return AllMyRating(ratingsList: snapshot.data!,);
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
    );
  }
}
