import 'package:flutter/material.dart';
import 'package:home_services/Log%20out/Api/Log_out_Api.dart';
import 'package:home_services/user_profile/user_profile.dart';
import 'Drawer/Widget/home_page_drawer.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {

  var user;
  HomePage({
    required this.user,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Home Page"),
            ),
            drawer: Drawer(
              child: Drawer_(user: widget.user),
            ),
            body: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      LogOutApi op = LogOutApi();
                      //print(widget.user.token);
                      op.logOut();
                    },
                    child: const Text("clear data"),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      print(widget.user.mode);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserProfile(user: widget.user,)));
                    },
                    child: const Text("go"),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }


}