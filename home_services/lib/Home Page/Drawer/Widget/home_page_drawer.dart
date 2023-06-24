import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Drawer/Widget/drawer_components.dart';


// ignore: camel_case_types, must_be_immutable
class Drawer_ extends StatefulWidget {
  var user;
  Drawer_({
    super.key,
    required this.user,
});
  @override
  State<StatefulWidget> createState() => DrawerState();
}

class DrawerState extends State<Drawer_> {
  List drawerComponents = [];

  @override
  Widget build(BuildContext context) {
    return Column(
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

                  },
                  text: "My bills",
                  iconColor: Colors.blue,
                  color: Colors.black87,
                  icon: Icons.receipt),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Drawer_component(
                  onTap: (){

                  },
                  text: "My friends",
                  iconColor: Colors.blue,
                  color: Colors.black87,
                  icon: Icons.people),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Drawer_component(
                  onTap: (){

                  },
                  text: "My notifications",
                  color: Colors.black87,
                  iconColor: Colors.blue,
                  icon: Icons.notification_important_rounded),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Drawer_component(
                onTap: (){

                },
                text: "my kanader",
                iconColor: Colors.blue,
                color: Colors.black87,
                icon: Icons.kayaking_rounded,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Drawer_component(
                  onTap: (){

                  },
                  text: "my shabasheb",
                  color: Colors.black87,
                  iconColor: Colors.blue,
                  icon: Icons.accessible_sharp),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Drawer_component(
                  onTap: (){

                  },
                  iconColor: Colors.blue,
                  text: "my sanadel",
                  color: Colors.black87,
                  icon: Icons.account_tree_sharp),
            ),
            const SizedBox(
              height: 20,
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
                text: "Loge out",
                iconColor: Colors.blue,
                color: Colors.black87,
                icon: Icons.logout,
              ),
            )
          ],
        )
      ],
    );
  }
}
