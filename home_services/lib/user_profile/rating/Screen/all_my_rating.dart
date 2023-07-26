import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/rating.dart';

import '../Widget/home_service_rate_item.dart';

// ignore: must_be_immutable
class AllMyRating extends StatelessWidget {
  List<HomeServiceRating> ratingsList;
  AllMyRating({Key? key,required this.ratingsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("تقييماتي"),
              backgroundColor: Colors.grey[700],
            ),
            body: (ratingsList.isEmpty)?Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: (ratingsList.isEmpty)? true : false,
                      child: const Text("لا يوجد تقييمات حاليا",style: TextStyle(
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
                  if(ratingsList.isNotEmpty)for(int i=0;i<ratingsList.length;i++)HomeServiceRateItem(op: ratingsList[i]),
                ],
              ),
            )
        ),
      ),
    );
  }
}
