import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Drawer/Screen/home_page_drawer.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/search/Widget/get_service_name_search_result.dart';

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
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              title: const Text("الصفحة الرئيسية"),
            ),
            drawer: Drawer(
              child: Drawer_(user: widget.user,category: widget.category),
            ),
            body: Column(
              children: [
                MyFild(
                  contorller: searchController,
                  hintText: "",
                  obscure: false,
                  lable: const Text("اسم الخدمة"),
                  readOnly: false,
                  rightPadding: 20.0,
                  leftPadding: 20.0,
                  color: Colors.white,
                  sidesColor: Colors.black,
                  suffixIcon: IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetServiceNameSearchResult(user: widget.user,titleController: searchController,)));
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
                /*Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      LogOutApi op = LogOutApi();
                      //print(widget.user.token);
                      op.logOut();
                    },
                    child: const Text("clear data"),
                  ),
                ),*/
              ],
            ),
          ),
        )
    );
  }


}