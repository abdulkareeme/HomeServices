import 'dart:convert';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInApis{

  Future<List?> login(var usernameController, var passwordController, var error) async {
    Response response = await post(Uri.parse(Server.host+Server.loginApi), body: {
      'email': usernameController.text,
      'password': passwordController.text,
    });
    print(usernameController.text+" one line");
    print(passwordController.text+' line tow');
    var info = [];
    if (response.statusCode == 200) {
      print(usernameController.text+' line three');
      print(passwordController.text+' line four');
      print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      var op = jsonDecode(response.body);
      print(op);
      info.add(op['user_info']['username']);
      info.add(op['user_info']['first_name']);
      info.add(op['user_info']['last_name']);
      info.add(op['user_info']['email']);
      info.add(op['user_info']['mode']);
      info.add(op['token'][0]);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('username',op['user_info']['username'].toString());
      print(op['user_info']['username']);
      pref.setString('first_name',op['user_info']['first_name'].toString());
      print(op['user_info']['first_name']);
      pref.setString('last_name', op['user_info']['last_name'].toString());
      print(op['user_info']['last_name']);
      pref.setString('email', op['user_info']['email'].toString());
      print(op['user_info']['email']);
      pref.setString('mode', op['user_info']['mode'].toString());
      print(op['user_info']['mode']);
      pref.setString('photo', op['user_info']['photo'].toString());
      String birthDate = "";
      for(int i=0;i<op['user_info']['birth_date'].length;i++){
        if(op['user_info']['birth_date'][i] != 'T'){
          birthDate += op['user_info']['birth_date'].toString()[i];
        }
      }
      pref.setString('birth_date', birthDate.toString());
      pref.setString('gender', op['user_info']['gender'].toString());
      pref.setBool('logout', false);
      (op['user_info']['bio'] != null)? pref.setString('bio',op['user_info']['bio'].toString()) : pref.setString('bio',"").toString();
      pref.setString('id', op['user_info']['id'].toString());
      //pref.setString('area', op['user_info']['area']);
      pref.setString('avg_answer', op['user_info']['average_fast_answer'].toString());
      pref.setString('token', op['token'][0].toString());
    } else {
      print(jsonDecode(response.body));
      print(usernameController.text+'line four');
      print(passwordController.text+'line five');
      error = "invalid username or password";
    }
    return info;
  }
  Future<List?> checkIfLoggedIn() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName, firstName , lastName, email, token;
    //bool? logOutCase = pref.getBool('logout')!;
    List? info = [];
    userName = await pref.getString('username');
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    print(userName.toString());
    firstName =await pref.getString('first_name');
    print(firstName);
    lastName = await pref.getString('last_name');
    print(lastName);
    email = await pref.getString('email');
    print(email);
    token = await pref.getString('token');
    print(token);
    info = [userName, firstName , lastName, email, token];
    return info;
  }
}

