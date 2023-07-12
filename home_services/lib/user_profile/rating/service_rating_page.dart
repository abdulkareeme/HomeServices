import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/rating.dart';
import 'package:home_services/user_profile/rating/rate_item.dart';


class ThisServiceRating extends StatelessWidget {
  List <Rating> ratingsList;
  var user;
  ThisServiceRating({Key? key,required this.ratingsList,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("التقييمات"),
          ),
          body: (ratingsList.isEmpty)?Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   Visibility(
                      visible: (ratingsList.isEmpty)? true : false,
                      child: const Text("لم يتم تقييم هذه الخدمة حاليا",style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                      ),),
                    ),
                ],
              ),
            ),
          ) : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                if(ratingsList.isNotEmpty)for(int i=0;i<ratingsList.length;i++)RateItem(op: ratingsList[i]),
              ],
            ),
          )
        ),
      ),
    );
  }
}
