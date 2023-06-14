import 'dart:convert';
import 'dart:ffi';

import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  Future<List> setUserNewData(List newData) async {
    try {
      Map<String, dynamic> updateInfoToJson() {
        return {
          "bio":newData[3],
          "user":{
            "first_name" : "${newData[0].text}",
            "last_name" : "${newData[1].text}",
            "birth_date" :"${newData[2].text}",
            "area" : newData[4],
          }
        };
      }
      final body = jsonEncode(updateInfoToJson());
      Response response =
          await put(Uri.parse(Server.host + Server.updateInfo),
            headers: {
              "Authorization": 'token ${newData[5]}',
              'Content-Type': 'application/json',
            },body:body);
      if (response.statusCode == 200) {
        var newInfo = jsonDecode(response.body);

      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
      print("ops");
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('first_name', newData[0].toString());
    await pref.setString('last_name', newData[1].toString());
    await pref.setString('bio', newData[2].toString());
    await pref.setString('birth_date', newData[3].toString());
    String? userName, firstName, lastName, email, token;
    var newInfo = [];
    userName = await pref.getString('username');
    firstName = await pref.getString('first_name');
    lastName = await pref.getString('last_name')!;
    email = await pref.getString('email');
    token = await pref.getString('token');
    newInfo = [userName, firstName, lastName, email, token];
    return newInfo;
  }

  static Future imagePicker(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      print("no such image");
    }
  }
}
