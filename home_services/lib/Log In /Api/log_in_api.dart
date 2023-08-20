import 'dart:convert';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Main Classes/user.dart';
//import 'package:home_services/user.dart';

class LogInApis {
  Future setData(var info) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('photo', info['user_info']['photo']);
    await pref.setString('username', info['user_info']['username']);
    await pref.setString('email', info['user_info']['email']);
    await pref.setString('token', info['token'][0]);
    await pref.setString("joined_date", info['user_info']["date_joined"]);
    print(info['token'][0]);
    await pref.setInt('id', info['user_info']['id']);
    print(info['user_info']['id']);
    await pref.setString(
        'first_name', utf8.decode(info['user_info']['first_name'].toString().codeUnits));
    print(utf8.decode(info['user_info']['first_name'].toString().codeUnits));
    String ls = utf8.decode(info['user_info']['last_name'].toString().codeUnits);
    await pref.setString(
        'last_name',ls);
    print(ls);
    await pref.setString('mode', info['user_info']['mode']);
    print(info['user_info']['mode']);
    await (info['user_info']['birth_date'] != null)
        ? pref.setString('birth_date', info['user_info']['birth_date'])
        : pref.setString('birth_date', "");
    await pref.setString('gender', info['user_info']['gender']);
    print(info['user_info']['gender']);
    await (info['user_info']['bio'] != null)
        ? pref.setString('bio', utf8.decode(info['user_info']['bio'].toString().codeUnits))
        : pref.setString('bio', "");
    (info['user_info']['average_fast_answer'] != null)
        ? await pref.setString(
            'answer_speed', info['user_info']['average_fast_answer'])
        : await pref.setString('answer_speed', "");
    //print(info['user_info']['average_fast_answer']+"  helloo");
    (info['user_info']['clients_number'] != null)
        ? await pref.setInt(
            'clients_number', info['user_info']['clients_number'])
        : await pref.setInt('clients_number', 0);
    (info['user_info']['services_number'] != null)
        ? await pref.setInt(
            'services_number', info['user_info']['services_number'])
        : await pref.setInt('services_number', 0);
    (info['user_info']['average_rating'] != null)
        ? await pref.setDouble('rating', info['user_info']['average_rating'].toDouble())
        : await pref.setDouble('rating', 0.0);
    await pref.setString('area_name',utf8.decode(info['user_info']['area_name'].toString().codeUnits));
    //print(info['user_info']['area_name']);
    await pref.setInt('area_id', info['user_info']["area_id"]);
  }

  Future<List?> login(
      var emailController, var passwordController,) async {
    try {
      Response response =
          await post(Uri.parse(Server.host + Server.loginApi), body: {
        'email': emailController.text,
        'password': passwordController.text,
      });
      var list = [];
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        //print(info);
        print(info['user_info']['average_rating'].runtimeType);
        if(info['user_info']['mode'] != "client"){
          Seller seller = Seller.noPhoto(
              (info['user_info']['services_number'] != null)
                  ? info['user_info']['services_number']
                  : 0,
              info['user_info']["id"],
              (info['user_info']['clients_number'] != null)
                  ? info['user_info']['clients_number']
                  : 0,
              info['user_info']["area_id"],
              utf8.decode(info['user_info']['first_name'].toString().codeUnits),
              utf8.decode(info['user_info']["last_name"].toString().codeUnits),
              info['user_info']["username"],
              (info['user_info']['average_fast_answer'] != null)
                  ? info['user_info']['average_fast_answer']
                  :  "",
              info['user_info']['email'],
              info['token'][0],
              info['user_info']['mode'],
              info['user_info']['gender'],
              info['user_info']['birth_date'],
              info['user_info']["date_joined"],
              utf8.decode(info['user_info']["area_name"].toString().codeUnits),
              (info['user_info']['bio'] != null)
                  ? utf8.decode(info['user_info']['bio'].toString().codeUnits)
                  :  "",
              info['user_info']['photo'],
              (info['user_info']['average_rating'] != null)
                  ? info['user_info']['average_rating'].toDouble()
                  : 0.0);
          list.add(seller);
        } else {
          User user = User.noPhoto(
              utf8.decode(info['user_info']['first_name'].toString().codeUnits),
              utf8.decode(info['user_info']['last_name'].toString().codeUnits),
              info['user_info']["username"],
              info['user_info']["email"],
              info["token"][0],
              info['user_info']["mode"],
              info['user_info']["gender"],
              info['user_info']["birth_date"],
              info['user_info']["date_joined"],
              utf8.decode(info['user_info']["area_name"].toString().codeUnits),
              (info['user_info']['bio'] != null)
                  ? utf8.decode(info['user_info']['bio'].toString().codeUnits)
                  :  "",
              info['user_info']["photo"],
              info['user_info']["area_id"],
              info['user_info']["id"]);
          list.add(user);
        }
        setData(info);
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        print(response.statusCode);
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  Future<List?> checkIfLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List? info = [];
    int ? id ,serviceNumber,clientsNumber,areaId;
    double? rating;
    String? firstName,lastName,userName,answerSpeed,email,token,gender,birthDate,joinedDate,areaName,bio,mode,photo;
    photo = await pref.getString("photo");
    firstName =  await pref.getString("first_name");
    lastName = await pref.getString('last_name');
    userName = await pref.getString('username');
    email = await pref.getString('email');
    token = await pref.getString('token');
    mode = await pref.getString('mode');
    birthDate = await pref.getString('birth_date');
    joinedDate = await pref.getString("joined_date");
    bio = await pref.getString('bio');
    gender = await pref.getString('gender');
    areaName = await pref.getString('area_name');
    areaId = await pref.getInt('area_id');
    id = await pref.getInt('id');
    if(firstName != null && lastName != null && userName != null && email != null && token != null && areaName != null && mode != null && gender != null && birthDate != null && joinedDate != null && bio != null && areaId != null && id != null){
      if(mode == "seller"){
        serviceNumber = await pref.getInt('services_number');
        answerSpeed = await pref.getString('answer_speed');
        rating = await pref.getDouble('rating')!;
        clientsNumber = await pref.getInt('clients_number');
        Seller seller = Seller.noPhoto(
            serviceNumber!,
            id,
            clientsNumber,
            areaId,
            firstName,
            lastName,
            userName,
            answerSpeed,
            email,
            token,
            mode,
            gender,
            birthDate,
            joinedDate,
            areaName,
            bio,
            photo,
            rating);
        info.add(seller);
        return info;
      }else{
        User user = User.noPhoto(
            firstName,
            lastName,
            userName,
            email,
            token,
            mode,
            gender,
            birthDate,
            joinedDate,
            areaName,
            bio,
            photo,
            areaId,
            id);
        info.add(user);
        return info;
      }
    } else{
      return info;
    }
  }
}
