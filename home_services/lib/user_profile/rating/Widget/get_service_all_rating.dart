import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/rating.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/rating/Screen/service_rating_page.dart';

class GetServiceAllRating extends StatelessWidget {
  var user;
  int id;
  GetServiceAllRating({Key? key,required this.user,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return Scaffold(
      body: FutureBuilder(
        future:ob.getServiceAllRating(id, user),
        builder: (context,AsyncSnapshot<List<Rating>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.connectionState == ConnectionState.done){
              return ThisServiceRating(
                user: user,
                ratingsList: snapshot.data!,
              );
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
