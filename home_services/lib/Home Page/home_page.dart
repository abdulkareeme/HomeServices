import 'package:flutter/material.dart';
import 'package:home_services/Log%20out/Api/Log_out_Api.dart';
import 'Drawer/Widget/home_page_drawer.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  var user;
  List category;
  HomePage({
    required this.user,
    required this.category,
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
              child: Drawer_(user: widget.user,category: widget.category),
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
                      final now = DateTime.now();
                      final difference = now.difference(DateTime.parse("2023-07-10 12:30:00"));
                      final hours = difference.inHours;
                      final days = difference.inDays;
                      final minutes = difference.inMinutes.remainder(60);
                      final seconds = difference.inSeconds.remainder(60);
                      print(hours);
                      print(minutes);
                      print(seconds);
                      print(days);
                      final months = days/30;
                      print(months.toInt());
                      print(months/12.toInt());
                      /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SellerServiceDetails(user: widget.user,)));*/
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