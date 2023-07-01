import 'package:flutter/material.dart';
import 'package:home_services/user_profile/list_my_services/service_item.dart';

import 'fetch_service_detail.dart';

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
      child: (
        Scaffold(
          body: SingleChildScrollView(
            child: (services.isEmpty)?const Center(child: Text("ليس لديك خدمات حاليا"),):Column(
              children: [
                 for(int i=0;i<services.length;i++)ServiceItem(service: services[i],user: user,onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                    id: services[i].id,
                    user: user,
                  )));
                }),
              ],
            ),
          ),
        )
      ),
    );
  }
}
