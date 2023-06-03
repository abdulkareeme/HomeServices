import 'dart:convert';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInApis {
  
  Future setData(var info) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', info['user_info']['username']);
    await pref.setString('email', info['user_info']['email']);
    await pref.setString('token', info['token'][0]);
    print(info['token'][0]);
    await pref.setInt('id', info['user_info']['id']);
    print(info['user_info']['id']);
    await pref.setString('first_name', info['user_info']['first_name'].toString());
    print(info['user_info']['first_name']);
    await pref.setString('last_name', info['user_info']['last_name'].toString());
    print(info['user_info']['last_name']);
    await pref.setString('mode', info['user_info']['mode']);
    print(info['user_info']['mode']);
    await (info['user_info']['birth_date'] != null)?pref.setString('birth_date', info['user_info']['birth_date']):pref.setString('username', "");
    await pref.setString('gender', info['user_info']['gender']);
    print(info['user_info']['gender']);
    await (info['user_info']['bio'] != null)?pref.setString('bio', info['user_info']['bio']):pref.setString('bio', "");
    (info['user_info']['average_fast_answer'] != null)?await pref.setString('answer_speed', info['user_info']['average_fast_answer']):await pref.setString('answer_speed', "");
    print(info['user_info']['average_fast_answer']);
    (info['user_info']['clients_number'] != null)?await pref.setInt('clients_number', info['user_info']['clients_number']):await pref.setInt('clients_number', 0);
    (info['user_info']['services_number']!= null)?await pref.setInt('services_number', info['user_info']['services_number']):await pref.setInt('services_number',0);
    (info['user_info']['average_rating']!= null)?await pref.setDouble('rating', info['user_info']['average_rating']):await pref.setDouble('rating', 0);
    await pref.setString('area_name', info['user_info']['area_name']);
  }
  Future<List?> login(var emailController , var passwordController, var error)async {
    try{
      Response response = await post(Uri.parse(Server.host+Server.loginApi),
      body:{
        'email' : emailController.text,
        'password' : passwordController.text,
      });
      var list =[];
      if(response.statusCode == 200){
        var info = jsonDecode(response.body);
        list.add(info['user_info']['username']);
        list.add(info['user_info']['email']);
        list.add(info['user_info']['first_name']);
        list.add(info['user_info']['last_name']);
        list.add(info['token'][0]);

        setData(info);

      } else {
        print(jsonDecode(response.body));
        print(response.statusCode);
      }
      return list;
    }catch(e){
      print(e);
    }
  }
  
  Future<List?> checkIfLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName, firstName, lastName, email, token;
    //bool? logOutCase = pref.getBool('logout')!;
    List? info = [];
    userName = await pref.getString('username');
    print(userName.toString());
    firstName = await pref.getString('first_name');
    print(firstName);
    lastName = await pref.getString('last_name');
    print(lastName);
    email = await pref.getString('email');
    print(email);
    token = await pref.getString('token');
    print(token);
    info = [userName, firstName, lastName, email, token];
    return info;
  }
}

