import 'dart:convert';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Main Classes/service.dart';
import '../../Main Classes/category.dart';
import '../../Main Classes/area.dart';

class ProfileApi {
  Future<List?> setUserNewData(List newData) async {
    try {
      print(newData[0].text);
      print(newData[1].text);
      print(newData[2].text);
      Map<String, dynamic> updateInfoToJson() {
        return {
          "bio":newData[3].text,
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
        var info = jsonDecode(response.body);
        print(response.statusCode);
        print(info);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('username', info['username']);
        await pref.setString('email', info['email']);
        await pref.setString("joined_date", info["date_joined"]);
        await pref.setInt('id', info['id']);
        String fn = utf8.decode(info['first_name'].toString().codeUnits);
        await pref.setString('first_name',fn);
        String ln = utf8.decode( info['last_name'].toString().codeUnits);
        await pref.setString('last_name',ln);
        await pref.setString('mode', info['mode']);
        await (info['birth_date'] != null)
            ? pref.setString('birth_date', info['birth_date'])
            : pref.setString('birth_date', "");
        await pref.setString('gender', info['gender']);

        // fixe if user enter arabic bio
        String bio = utf8.decode( info['bio'].toString().codeUnits);
        await (info['bio'] != null)
            ? pref.setString('bio', bio)
            : pref.setString('bio', "");
        (info['average_fast_answer'] != null)
            ? await pref.setString(
            'answer_speed', info['average_fast_answer'])
            : await pref.setString('answer_speed', "");
        (info['clients_number'] != null)
            ? await pref.setInt(
            'clients_number', info['clients_number'])
            : await pref.setInt('clients_number', 0);
        (info['services_number'] != null)
            ? await pref.setInt(
            'services_number', info['services_number'])
            : await pref.setInt('services_number', 0);
        (info['average_rating'] != null)
            ? await pref.setInt('rating', info['average_rating'])
            : await pref.setInt('rating', 0);
        String an =utf8.decode(info['area_name'].toString().codeUnits);
        await pref.setString('area_name', an);
        await pref.setInt('area_id', info["area_id"]);
        String? userName, firstName, lastName, email, token;
        var newInfo = [];
        userName = await pref.getString('username');
        firstName = await pref.getString('first_name');
        lastName = await pref.getString('last_name')!;
        email = await pref.getString('email');
        token = await pref.getString('token');
        newInfo = [userName, firstName, lastName, email, token];
        return newInfo;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
      print("ops");
    }
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
  Future<List?> getCategories() async{

    try{
      Response response = await get(Uri.parse(Server.host+Server.listCategories));
      List finalCat = [];
      if(response.statusCode == 200){
        var cate = jsonDecode(response.body);
        print(cate);
        List os = cate;
        for(int i=0;i<os.length;i++){
          List op = [];
          op.add(cate[i]['id']);
          op.add(utf8.decode(cate[i]['name'].toString().codeUnits));
          finalCat.add(op);
        }
        return finalCat;
      } else {
        print(jsonDecode(response.body));
        return finalCat;
      }

    } catch (e) {
      print(e);
    }
  }


  Future<List?> createServeice(var titleController , var descriptionController, var priceController , var type, var areaList, var formList,var user )async{
    try{
      List toJson(var list){
        List<Map<String,dynamic>> op = [];
        for(int i=0;i<4;i++){
            op.add({
              "title": "${list[i][0].text}",
              "field_type" : (list[i][1].text == "نص")? "text":"number",
              "note":""
            });
        }
        for(int i=4;i<list.length;i++){
          op.add({
            "title": "${list[i][0].text}",
            "field_type" : "${list[i][1]}",
            "note":"${list[i][2].text}"
          });
        }
        return op;
      }
      var os = toJson(formList);
      Map<String ,dynamic> finalObject() {
        return{
          "title": titleController.text,
          "description": descriptionController.text,
          "category": type,
          "average_price_per_hour": priceController.text,
          "service_area":areaList,
          "form": os,
        };
      }
      final body = jsonEncode(finalObject());
      Response response = await post(Uri.parse(Server.host+Server.createService),
          headers: {
            "Authorization": 'token ${user.token}',
            'Content-Type': 'application/json',
          } ,

          body: body
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        var yes = ['done'];
        return yes;
      } else {
        var no = [];
        print(response.statusCode);
        print(jsonDecode(response.body));
        return no;
      }
    }catch (e){
      print (e);
    }
  }

  Future<List?> listMyServices(var user) async {
    try{
      Response response = await get(Uri.parse('${Server.host}${Server.listMyService}?username=${user.userName}'));
      if(response.statusCode == 200 ){
        var info = jsonDecode(response.body);
        List os = info;
        List services = [];
        for(int i=0;i<os.length;i++){
          List<Area> area= [];
          Category ob = Category(
              info[i]["category"]['id'],
              utf8.decode(info[i]["category"]['name'].toString().codeUnits)
          );
          for(int j=0 ;j<info[i]["service_area"].length;j++){
            Area o = Area(
                info[i]["service_area"][j]['id'],
                info[i]["service_area"][j]['name']
            );
            area.add(o);
          }
          Service service = Service(
              info[i]['id'],
              utf8.decode(info[i]["title"].toString().codeUnits),
              info[i]["average_ratings"],
              utf8.decode(info[i]["seller"]["user"]["first_name"].toString().codeUnits),
              utf8.decode(info[i]["seller"]["user"]["last_name"].toString().codeUnits),
              info[i]["seller"]["user"]["username"],
              info[i]["average_price_per_hour"],
              ob,
              area
          );
          services.add(service);
        }
        return services;
      } else {
        List op = [];
        return op;
      }
    } catch (e){
      print(e);
    }
  }

}
