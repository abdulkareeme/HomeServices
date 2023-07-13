import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../server/api_url.dart';

class ForgetPasswordApi{

  Future<List?> sendEmailForForgetPassword(TextEditingController email) async{

    try{
      Response response =await post(Uri.parse(""),
        body: {
          "email" : email.text
        }
      );
      if(response.statusCode == 200){
        print(response.statusCode);
        List op = [];
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = ["ops"];
        return op;
      }
    } catch(e){
      print(e);
      List op = ['ops'];
      return op;
    }

  }

}
