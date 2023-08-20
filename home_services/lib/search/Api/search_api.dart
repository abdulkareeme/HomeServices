import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/area.dart';
import 'package:home_services/Main%20Classes/category.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:tuple/tuple.dart';

class SearchApi{

  // category and title search for the category section
  // we pass the category we want to search in and the title of the service we are looking for it
  // the user only need to enter the title, the category we get it from the category page
  Future<Tuple2<bool,List>> titleAndCategorySearch(TextEditingController title,var category)async{
    try{
      Response response = await get(Uri.parse("${Server.host}${Server.listMyService}?category=$category&title=${title.text}"));
      if(response.statusCode == 200){
        bool status = true;
        var info = jsonDecode(response.body);
        List os = info;
        List services = [];
        for (int i = 0; i < os.length; i++) {
          List<Area> area = [];
          Category ob = Category(info[i]["category"]['id'],
              utf8.decode(info[i]["category"]['name'].toString().codeUnits));
          for (int j = 0; j < info[i]["service_area"].length; j++) {
            Area o = Area(info[i]["service_area"][j]['id'],
                info[i]["service_area"][j]['name']);
            area.add(o);
          }
          Service service = Service(
              info[i]['id'],
              utf8.decode(info[i]["title"].toString().codeUnits),
              info[i]["average_ratings"],
              utf8.decode(
                  info[i]["seller"]["user"]["first_name"].toString().codeUnits),
              utf8.decode(
                  info[i]["seller"]["user"]["last_name"].toString().codeUnits),
              info[i]["seller"]["user"]["username"],
              info[i]["average_price_per_hour"],
              ob,
              area,
              info[i]["seller"]["user"]["photo"]);
          services.add(service);
        }
        return Tuple2(status, services);
      } else {
        print (response.statusCode);
        print (jsonDecode(response.body));
        bool status =false;
        List services = [];
        return Tuple2(status, services);
      }
    }catch(e){
      print(e);
      bool status =false;
      List services = [];
      return Tuple2(status, services);
    }
  }

  // home page search for the title of the service
  // we enter the title of the service and we get the result if it exist
  // the user enter the title only
  Future<Tuple2<bool,List>> titleSearch(TextEditingController title)async{
    try{
      Response response = await get(Uri.parse("${Server.host}${Server.listMyService}?title=${title.text}"));
      if(response.statusCode == 200){
        print(response.statusCode);
        bool status = true;
        var info = jsonDecode(response.body);
        print(info);
        List os = info;
        List services = [];
        for (int i = 0; i < os.length; i++) {
          List<Area> area = [];
          Category ob = Category(info[i]["category"]['id'],
              utf8.decode(info[i]["category"]['name'].toString().codeUnits));
          for (int j = 0; j < info[i]["service_area"].length; j++) {
            Area o = Area(info[i]["service_area"][j]['id'],
                info[i]["service_area"][j]['name']);
            area.add(o);
          }
          Service service = Service(
              info[i]['id'],
              utf8.decode(info[i]["title"].toString().codeUnits),
              info[i]["average_ratings"],
              utf8.decode(
                  info[i]["seller"]["user"]["first_name"].toString().codeUnits),
              utf8.decode(
                  info[i]["seller"]["user"]["last_name"].toString().codeUnits),
              info[i]["seller"]["user"]["username"],
              info[i]["average_price_per_hour"],
              ob,
              area,
              info[i]["seller"]["user"]["photo"]);
          /*Service service = Service(
            info[i]['id'],
            utf8.decode(info[i]["title"].toString().codeUnits),
            info[i]["average_ratings"],
            utf8.decode(
                info[i]["seller"]["user"]["first_name"].toString().codeUnits),
            utf8.decode(
                info[i]["seller"]["user"]["last_name"].toString().codeUnits),
            info[i]["seller"]["user"]["username"],
            info[i]["average_price_per_hour"],
            ob,
            area,
          );*/
          services.add(service);
        }
        return Tuple2(status, services);
      } else {
        print (response.statusCode);
        print (jsonDecode(response.body));
        bool status =false;
        List services = [];
        return Tuple2(status, services);
      }
    }catch(e){
      print(e);
      bool status =false;
      List services = [];
      return Tuple2(status, services);
    }
  }

}