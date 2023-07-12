import 'dart:convert';

import 'package:home_services/Main%20Classes/user.dart';
import 'package:http/http.dart';

import '../../Main Classes/area.dart';
import '../../Main Classes/category.dart';
import '../../Main Classes/service.dart';
import '../../server/api_url.dart';

class HomePageApi{

  Future<List?> getThisCategoryServices (var category) async{
    try{
      // ignore: prefer_interpolation_to_compose_strings
      Response response = await get(Uri.parse("${Server.host}${Server.listMyService}?category="+category));
      if(response.statusCode == 200){
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
              area,
          );
          services.add(service);
        }
          return services;
        } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op =[];
        return op;
      }
    } catch (e){
      print(e);
    }
  }

  Future<List?> getUserDetails(String username) async{
    bool firstFunction = false;
    bool secondFunction =false;
    List op =[];
    try{
      Response response = await get(Uri.parse(Server.host+Server.getUserDetails+username));
      if(response.statusCode == 200){
        firstFunction = true;
        var info = jsonDecode(response.body);
        if(info['mode'] != "client"){
          /*print(info['services_number'].runtimeType);
          print(info["id"].runtimeType);
          print(info["area_id"].runtimeType);
          print(info['first_name'].runtimeType);
          print(info["last_name"].runtimeType);
          print(info["username"].runtimeType);
          print(info['average_fast_answer'].runtimeType);
          print(info['email'].runtimeType);
          print(info['mode'].runtimeType);
          print(info['gender'].runtimeType);
          print(info['birth_date'].runtimeType);
          print(info["date_joined"].runtimeType);
          print(info["area_name"].runtimeType);
          print(info["bio"].runtimeType);
          print(info['average_rating'].runtimeType);*/
          Seller seller = Seller.noPhoto(
              (info['services_number'] != null)
                  ? info['services_number']
                  : 0,
              info["id"],
              (info['clients_number'] != null)
                  ? info['clients_number']
                  : 0,
              info["area_id"],
              utf8.decode(info['first_name'].toString().codeUnits),
              utf8.decode(info["last_name"].toString().codeUnits),
              info["username"],
              (info['average_fast_answer'] != null)
                  ? info['average_fast_answer']
                  :  "",
              info['email'],
              "0",
              info['mode'],
              info['gender'],
              info['birth_date'],
              info["date_joined"],
              utf8.decode(info["area_name"].toString().codeUnits),
              utf8.decode(info["bio"].toString().codeUnits),
              (info['average_rating'] != null)
                  ? info['average_rating']
                  : 0);

          op.add(seller);
        } else {
          User user = User.noPhoto(
              utf8.decode(info['first_name'].toString().codeUnits),
              utf8.decode(info['last_name'].toString().codeUnits),
              info["username"],
              info["email"],
              "0",
              info["mode"],
              info["gender"],
              info["birth_date"],
              info["date_joined"],
              utf8.decode(info["area_name"].toString().codeUnits),
              (info['bio'] != null)
                  ? utf8.decode(info["bio"].toString().codeUnits)
                  :  "",
              info["area_id"],
              info["id"]
          );
          op.add(user);
        }
      } else {
        print (response.statusCode);
        print(jsonDecode(response.body));
      }
    }catch(e){
      print(e);
    }


    try{
      Response response = await get(Uri.parse("${Server.host}${Server.listMyService}?username=$username"));
      if(response.statusCode == 200 ){
        secondFunction = true;
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
       op.add(services);
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
      }
    }catch(e){
     print (e);
    }
    if(firstFunction && secondFunction){
      return op;
    } else {
      List o = [];
      return o;
    }
  }

  Future<List?> getOrderedServiceForm (int id,var user) async {
    try{
      Response response = await get(Uri.parse("${Server.host}${Server.orderServiceForm}$id"),
        headers: {
          "Authorization": 'token ${user.token}',
        }
      );
      if(response.statusCode == 200){
        var info = jsonDecode(response.body);
        List os = info;
        List op = [];
        for(int i=0;i<os.length;i++){
          List o = [];
          o.add(info[i]['id']);
          o.add(utf8.decode(info[i]['title'].toString().codeUnits));
          o.add(info[i]['field_type']);
          o.add(utf8.decode(info[i]['note'].toString().codeUnits));
          op.add(o);
        }
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = [];
        return op;
      }
    } catch(e) {
      print (e);
      List op = [];
      return op;
    }
  }
  Future<List?> postOrder(int serviceId,var user,List formAnswer) async{
    try{
      var days ;
      List<Map<String,dynamic>> toJson(List op){
        List<Map<String,dynamic>> data = [];
        for(int i=0;i<op.length;i++){
          if(i == 3){
            days = op[i][1].text;
          }
          data.add({
            "field": op[i][0],
            "content":op[i][1].text,
          });
        }
        return data;
      }
      print(days);
      var ops = toJson(formAnswer);
      Map<String,dynamic> finalBody (){
        return ({
          "expected_time_by_day_to_finish":days,
          "form_data": ops,
        });
      }
      final body = jsonEncode(finalBody());
      print(body);
      Response response = await post(Uri.parse("${Server.host}${Server.makeOrder}$serviceId"),
        headers: {
          "Authorization": 'token ${user.token}',
          'Content-Type': 'application/json',
        },
        body:body,
      );
      if(response.statusCode == 200){
        print(200);
        print(jsonDecode(response.body));
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = [];
        return op;
      }
    } catch (e){
      print(e);
      List op = [];
      return op;
    }
  }
}