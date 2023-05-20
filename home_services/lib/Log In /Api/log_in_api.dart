import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LogInApi extends StatefulWidget{
  const LogInApi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LogInApiState();

}

class _LogInApiState extends State<LogInApi>{



  @override
  Widget build(BuildContext context) {
     Future logInApi() async{
      try {
        Response response = await post(
            Uri.parse('https://abdukarimedr.pythonanywhere.com/api/login/'),
            body: {
              'username': widget.userNameControler.text,
              'password': widget.passwordContoler.text,
            });

        if (response.statusCode == 200) {
          var info = jsonDecode(response.body);
          print(info);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username',info['user_info']['username']);
          await prefs.setString('email', info['user_info']['email']);
          await prefs.setString('token', info['token'][0]);
          await prefs.setString('vip_mode', info['vip_mode']);
          print(info['user_info']['username']);
          print(info['user_info']['email']);
          print(info['token'][0].toString());
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage(username: info['user_info']['username'], email: info['user_info']['email'], token: info['token'][0],vipMode: info['vip_mode'],)));
        } else {
          var error = jsonDecode(response.body);
          print(error);
          if (error['username'] != null) {
            String old = error['username'].toString();
            String newerror = old.substring(1, old.length - 1);
            setState(() {
              usernameError = newerror;
            });
          }
          if (error['password'] != null) {
            String old = error['password'].toString();
            String newerror = old.substring(1, old.length - 1);
            setState(() {
              passwordError = newerror;
            });
          }
        }
      } on HttpException catch (e) {
        print(e.message);
      }
    }
    return Container();
  }
  }