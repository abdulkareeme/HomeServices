import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../server/api_url.dart';

class ForgetPasswordApi{

  // first step of forget password process
  // we send the user email to determined the user tha he want to change his/her password and send the confirm code to the email
  // this function take user email

  Future<List?> sendEmailForForgetPassword(TextEditingController email) async{

    try{
      Response response =await post(Uri.parse(Server.host+Server.forgetPasswordSendEmail),
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

  // this function to send the confirm code that send to the user email
  // this function take user email and confirm code

  Future<List?> sendVerificationCodeForForgetPassword(TextEditingController email,String code) async{
    try{
      Response response =await post(Uri.parse(Server.host+Server.forgetPasswordVerificationCode),
          body: {
            "email" : email.text,
            "forget_password_code": code,
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

  // this function to update the password
  // we send the email and the confirm code and the new password and its confirm

  Future<List?> resetForgetPassword(TextEditingController email,String code,TextEditingController password,TextEditingController confirmPassword) async{

    try{
      Response response =await post(Uri.parse(Server.host+Server.resetForgetPassword),
          body: {
            "email" : email.text,
            "forget_password_code": code,
            "new_password":password.text,
            "new_password2":confirmPassword.text,
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
