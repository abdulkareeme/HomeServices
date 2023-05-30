import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import '../../Log In /Widget/Log_In_page.dart';

class SignUpApi{
  Future postVerificationCode(var code, var email,BuildContext context) async{
    //String url = "http://abdulkareemedres.pythonanywhere.com/api/confirm_email";
    String initialError = "";
    Response response = await post(Uri.parse(Server.host+Server.userConfirmCode),body: {
      'email': email,
      'confirmation_code' : code,
    });
    print('hellllllllllloooooooo');
    print(code);
    var responseBody = jsonDecode(response.body);
    if(response.statusCode == 200){
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn(error: initialError,)));
    } else {
      print(code);
      print(responseBody);
    }
  }
}