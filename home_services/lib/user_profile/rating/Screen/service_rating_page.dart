import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/rating.dart';

import '../Widget/rate_item.dart';


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
            backgroundColor: Colors.grey[700],
          ),
          body: (ratingsList.isEmpty)?Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   Visibility(
                      visible: (ratingsList.isEmpty)? true : false,
                      child: Wrap(
                        children:const [
                          Text("لم يتم تقييم هذه الخدمة حاليا",style: TextStyle(
                              fontSize: 100,
                              color: Colors.black38
                          ),)
                        ],
                      ),
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
