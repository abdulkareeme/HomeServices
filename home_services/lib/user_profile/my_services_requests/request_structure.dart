import 'package:flutter/material.dart';

import '../../style/user_request_style.dart';

class RequestStructure extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RequestStructureState();

}

class _RequestStructureState extends State<RequestStructure>{
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          const SizedBox(height: 5,),
          Text("طلب احمد كنعان خدمة صيانة البراد ",style: UserRequestStyle.requestTitleStyle(),),
          const SizedBox(height: 5,),
          const Text("مشروع الاوقاف مقابل حديقة الاماكن"),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
                onPressed: (){

              }, child:const Text("قبول الطلب")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                onPressed: (){

              }, child:const Text("رفض الطلب")),
            ],
          ),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }

}