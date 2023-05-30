import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DrawerApi {

  static Future<List?> getMyBills (var token) async{
    String  url = "https://abdukarimedr.pythonanywhere.com/bill/list_my_bills";
    Response response = await get(
      Uri.parse(url),
      headers: {
        'Authorization' : 'token $token',
      }
    );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    } else{
      print("ERRRRRRRRRRRRRRRROR");
      print(response.body);
    }
  }


}