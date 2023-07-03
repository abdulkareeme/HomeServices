import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Drawer/Widget/drawer_components.dart';

import '../../../user_profile/user_profile.dart';
import '../../multi_level_drop_down_menu.dart';


// ignore: camel_case_types, must_be_immutable
class Drawer_ extends StatefulWidget {
  var user;
  List category;
  Drawer_({
    super.key,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserProfile(user: widget.user,)));
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
