import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/show_service_item.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;
import '../style/user_profile_style.dart';


// ignore: must_be_immutable
class UserDetails extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  var service;
  UserDetails({Key? key,required this.user,required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var constHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection:ui.TextDirection.rtl,
        child: Scaffold(
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
                        backgroundImage:(user.gender == "Male")? const AssetImage('images/male.jpeg'):const AssetImage('images/female.jpeg'),
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
                            "نبذة عني :",
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40,right: 30),
                      child: Row(
                        children:  [
                          Text("الخدمات : ",style: UserProfileStyle.bioTitleStyle(),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2,right: 2),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: GridView.builder(
                            itemCount: service.length,
                            scrollDirection: Axis.horizontal,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 3),
                            itemBuilder: (context,i){
                              return ShowServiceItem(service: service[i]);
                            }),
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
