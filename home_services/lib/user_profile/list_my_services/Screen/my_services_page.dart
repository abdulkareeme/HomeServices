import 'package:flutter/material.dart';
import 'package:home_services/user_profile/list_my_services/Widget/fetch_service_detail.dart';
import 'package:home_services/user_profile/list_my_services/Widget/service_item.dart';

// ignore: must_be_immutable
class MyServices extends StatelessWidget {
  List services;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  MyServices({
    required this.services,
    this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: (
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              title: const Text("خدماتي"),
            ),
            body: SingleChildScrollView(
              child: (services.isEmpty)?const Center(child: Text("ليس لديك خدمات حاليا"),):Column(
                children: [
                   for(int i=0;i<services.length;i++)ServiceItem(service: services[i],user: user,onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                      id: services[i].id,
                      user: user,
                      userSellerCase: false,
                    )));
                  }),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
