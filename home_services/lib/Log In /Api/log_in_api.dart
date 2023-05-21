import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInApi{

  static Future<List?> logIn(var usernameController, var passwordController) async {
    String url = "";
    Response response = await http.post(Uri.parse(url),
    body:{
      'username' : usernameController.text,
      'password' : passwordController.text,
    });

    return jsonDecode(response.body);
  }
  static void setSharedPreferences (var userName , var email , var token ,var fullName,var lastName)async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', userName.toString())!;
    await pref.setString('email', email).toString()!;
    await pref.setString('token', token.toString())!;
    await pref.setString('full_name', fullName.toString())!;
    await pref.setString('last_name', lastName.toString())!;
  }
}

