import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInApis{

  Future<List?> login(var usernameController, var passwordController, var error) async {
    String url = "http://abdulkareemedres.pythonanywhere.com/api/login/";
    Response response = await post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text,
    });
    List info = [];
    if (response.statusCode == 200) {
      var op = jsonDecode(response.body);
      print(op);
      info.add(op['user_info']['username']);
      info.add(op['user_info']['first_name']);
      info.add(op['user_info']['last_name']);
      info.add(op['user_info']['email']);
      info.add(op['user_info']['mode']);
      info.add(op['token'][0]);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('username',op['user_info']['username']);
      pref.setString('first_name',op['user_info']['first_name']);
      pref.setString('last_name', op['user_info']['first_name']);
      pref.setString('email', op['user_info']['email']);
      pref.setString('mode', op['user_info']['mode']);
      pref.setString('photo', op['user_info']['photo']);
      String birthDate = "";
      for(int i=0;i<op['user_info']['birth_date'].length;i++){
        if(op['user_info']['birth_date'][i] != 'T'){
          birthDate += op['user_info']['birth_date'][i];
        }
      }
      pref.setString('birth_date', birthDate);
      pref.setString('gender', op['user_info']['gender']);
      (op['user_info']['bio'] != null)? pref.setString('bio',op['user_info']['bio']) : pref.setString('bio',"");
      pref.setString('id', op['user_info']['id']);
      //pref.setString('area', op['user_info']['area']);
      pref.setString('avg_answer', op['user_info']['average_fast_answer']);
      pref.setString('token', op['token'][0]);
    } else {
      error = "invalid username or password";
    }
    return info;
  }
}

