import 'package:flutter/material.dart';
import 'package:home_services/user_profile/list_my_services/service_item.dart';

// ignore: must_be_immutable
class MyServices extends StatelessWidget {
  List services;
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
            child: Column(
              children: [
                for(int i=0;i<services.length;i++)ServiceItem(service: services[i],user: user,),
              ],
            ),
          ),
        )
      ),
    );
  }
}
