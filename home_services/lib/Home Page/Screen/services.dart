import 'package:flutter/material.dart';
import 'package:home_services/user_profile/list_my_services/Widget/fetch_service_detail.dart';
import 'package:home_services/user_profile/list_my_services/Widget/service_item.dart';

// ignore: must_be_immutable
class Services extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var services, user;
  Services({Key? key,required this.services,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (services.length == 0)?const Center(child: Text("لا توجد خدمات بهذا الاسم",style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 28,
        color: Colors.black38
    ),),):SingleChildScrollView(
      child: Column(
        children: [
          for(int i=0;i<services.length;i++)if(services[i].creatorUserName!=user.userName)ServiceItem(service: services[i],user: user,onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
              userSellerCase: true,
              id: services[i].id,
              user: user,
            )));
          }),
        ],
      ),
    );
  }
}
