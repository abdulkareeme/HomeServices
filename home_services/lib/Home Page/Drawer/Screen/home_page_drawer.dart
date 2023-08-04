import 'package:flutter/material.dart';
import 'package:home_services/Animation/animation.dart';
import 'package:home_services/Home%20Page/Drawer/Widget/drawer_components.dart';
import 'package:home_services/Home%20Page/Widget/multi_level_drop_down_menu.dart';
import 'package:home_services/Log%20out/Widget/log_out.dart';

import '../../../user_profile/user_profile.dart';


// ignore: camel_case_types, must_be_immutable
class Drawer_ extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  List category;
  int myBalance;
  Drawer_({
    super.key,
    required this.myBalance,
    required this.user,
    required this.category,
});
  @override
  State<StatefulWidget> createState() => DrawerState();
}

class DrawerState extends State<Drawer_> {
  List drawerComponents = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[700]
            ),
            accountName: Text(widget.user!.firstName +" "+ widget.user!.lastName),

            accountEmail: Text(widget.user.email),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Drawer_component(
                    onTap: (){
                      Navigator.of(context).push(SlideRight(page: UserProfile(user: widget.user, myBalance: widget.myBalance,)));
                    },
                    text: "حسابي الشخصي",
                    iconColor: Colors.blue,
                    color: Colors.black87,
                    icon: Icons.person),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: MultiLevelDropDown(
                  user: widget.user,
                  categoryList: widget.category,
                  title: "التصنيفات",
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
              const SizedBox(
                height: 15,
              ),

              const SizedBox(height: 30,),

              Padding(
                padding:const EdgeInsets.only(right: 15),
                child: Drawer_component(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogOut(user: widget.user)));
                  },
                  text: "تسجيل خروج",
                  iconColor: Colors.blue,
                  color: Colors.black87,
                  icon: Icons.logout,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
