import 'package:flutter/material.dart';
import 'package:home_services/style/user_profile_style.dart';
import 'package:home_services/user_profile/list_my_services/Widget/service_item.dart';
import 'package:home_services/user_profile/rating/Widget/home_service_rate_item.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;


// ignore: must_be_immutable
class UserDetails extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  var service;
  var rating;
  UserDetails({Key? key,required this.user,required this.service,this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection:ui.TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            // ignore: prefer_interpolation_to_compose_strings
            title: Text("${" حساب "+user.firstName} "+user.lastName),
          ),
          body: (
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: constHeight / 14,
                    ),
                    Center(
                      child: InkWell(
                        child: CircleAvatar(
                        backgroundImage:NetworkImage(user.photo),
                        radius: 90,
                      ),
                      ),
                    ),
                    SizedBox(
                      height: constHeight / 37,
                    ),
                    Text(
                      user.firstName +" "+ user.lastName,
                      style: UserProfileStyle.usernameStyle(),
                    ),
                    SizedBox(
                      height: constHeight / 45,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person, color: Colors.black),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          (user.mode == "client")?"مستخدم":"بائع",
                          style: UserProfileStyle.locationStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constHeight / 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.areaName,
                          style: UserProfileStyle.locationStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constHeight / 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "تاريخ التسجيل ${DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(user.joinDate))}",
                          style: UserProfileStyle.locationStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constHeight / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        children: [
                          Text(
                            "النبذة :",
                            style: UserProfileStyle.bioTitleStyle(),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Divider(
                        color: Colors.black45,
                        thickness: 1.4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 33,right: 33),
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            Text(user.bio,style: UserProfileStyle.bioStyle(),)
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (service.length == 0)? false:true,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10,right: 30),
                        child: Row(
                          children:  [
                            Text("الخدمات : ",style: UserProfileStyle.bioTitleStyle(),),
                          ],
                        ),
                      ),
                    ),
                    for(int i=0;i<service.length;i++)Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10,bottom: 13,top: 15),
                      child: ServiceItem(service: service[i],user: user,onTap:null),
                    ),

                    Visibility(
                      visible: (service.length == 0)? false:true,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10,right: 30),
                        child: Row(
                          children:  [
                            Text("التقييمات : ",style: UserProfileStyle.bioTitleStyle(),),
                          ],
                        ),
                      ),
                    ),
                    for(int i=0;i<rating.length;i++)Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10,bottom: 13,top: 15),
                      child:HomeServiceRateItem(op: rating[i]),
                    ),

                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
