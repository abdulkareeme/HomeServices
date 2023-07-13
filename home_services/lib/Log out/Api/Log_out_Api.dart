import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../server/api_url.dart';

class LogOutApi{

  Future logOut () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
  Future<List?> logOute(var user) async{
    try{
      Response response = await post(Uri.parse(Server.host+Server.logOut),
        headers: {
          "Authorization": 'token ${user.token}',
        }
      );
      if(response.statusCode == 204){
        print(response.statusCode);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = [];
        return op;
      }
    } catch (e){
      print (e);
      List op = [];
      return op;
    }
  }
}
