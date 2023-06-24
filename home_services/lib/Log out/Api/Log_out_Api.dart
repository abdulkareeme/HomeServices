import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../server/api_url.dart';

class LogOutApi{

  Future logOut () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

  }
  Future logOut1 (var token) async{
    Response response = await post(Uri.parse(Server.host+Server.logOut),headers: {
      'Authorization': 'token $token',
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

  }
}
