import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import '../../Log In /Widget/Log_In_page.dart';

class SignUpApi{

  Future<List?> getAreaList()async{
    try{
      Response response = await get(Uri.parse(Server.host+Server.signupApi));
      List? areaList = [];
      if(response.statusCode == 200){
        var info = jsonDecode(response.body);
        List os = info;
        for(int i=0;i<os.length;i++){
          //print(info[i]["name"]);
          List o = [];
          o.add(info[i]["id"]);
          String op = info[i]['name'];
          o.add(utf8.decode(op.codeUnits));
          areaList.add(o);
        }
        return areaList;
      } else {
        return areaList;
      }
    } catch(e) {
      print(e);
    }
  }


  Future<List?> signUp(var data) async {
    try{
      Response response = await post(Uri.parse(Server.host+Server.signupApi), body: {
        'username': data[0],
        'password': data[1].text,
        'password2': data[2].text,
        'email': data[3].text,
        'first_name': data[4].text,
        'last_name': data[5].text,
        'birth_date': data[6].text,
        'gender': data[7],
        'mode': data[8],
        'area': data[9],
      });
      var op =["done"];
      if (response.statusCode == 200|| response.statusCode==201) {
        print (jsonDecode(response.body));
        return op;
      } else {
        var os = [];
        String ok = "";
        var info = jsonDecode(response.body);
        bool oq = false;
        if(info['email'] != null && info['password'] != null) oq = true;
        // ignore: prefer_interpolation_to_compose_strings
        if(info['email'] != null)ok+='email  : '+info['email'][0];
        if(oq)ok+='\n'+'\n' ;
        // ignore: prefer_interpolation_to_compose_strings
        if(info['password'] != null)ok+='password  : '+info['password'][0];
        os.add(ok);
        return os;
      }
    }catch(e){
      print(e);
    }
  }

  Future postVerificationCode(var code, var email,BuildContext context) async{
    try{
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
    }catch(e){
      print(e);
    }
  }
}