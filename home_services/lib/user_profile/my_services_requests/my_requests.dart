import 'package:flutter/material.dart';
import 'package:home_services/user_profile/my_services_requests/request_structure.dart';

class MyRequests extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyRequestsState();
}

class _MyRequestsState extends State<MyRequests>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(232, 220, 220, 1),
            appBar: AppBar(),
            body: Column(
              children: [
                ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return RequestStructure();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }


}