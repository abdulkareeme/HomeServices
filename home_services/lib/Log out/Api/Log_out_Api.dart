import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../server/api_url.dart';

class LogOutApi{

  Future logOut (BuildContext context) async{
    String initialLogInError= "";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    pref.setBool('logout', true);
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn(error: initialLogInError)));
  }
  Future logOut1 (var token) async{
    Response response = await post(Uri.parse(Server.host+Server.logOut),headers: {
      'Authorization': 'token $token',
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    // ignore: use_build_context_synchronously
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn(error: initialLogInError)));
  }
}
