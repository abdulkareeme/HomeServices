import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_services/Log%20out/Api/Log_out_Api.dart';
import 'package:home_services/user_profile/user_profile.dart';
import 'package:http/http.dart';

import 'Drawer/Widget/home_page_drawer.dart';


class HomePage extends StatefulWidget {

  var userInfo;
  HomePage({
    required this.userInfo,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
          ),
          drawer: Drawer(
            child: Drawer_(username: "Abd Alhadi", email: "abode2001a123@gmail.com",),
          ),
          body: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    LogOutApi op = LogOutApi();
                    op.logOut1(context);
                  },
                  child: const Text("clear data"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserProfile()));
                  },
                  child: const Text("go"),
                ),
              )
            ],
          ),
        )
    );
  }


}