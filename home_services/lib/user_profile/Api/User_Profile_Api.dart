import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/field.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/Main%20Classes/rating.dart';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import '../../Main Classes/form.dart';
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
          "bio": newData[3].text,
          "user": {
            "first_name": "${newData[0].text}",
            "last_name": "${newData[1].text}",
            "birth_date": "${newData[2].text}",
            "area": newData[4],
          }
        };
      }

      final body = jsonEncode(updateInfoToJson());
      Response response = await put(Uri.parse(Server.host + Server.updateInfo),
          headers: {
            "Authorization": 'token ${newData[5]}',
            'Content-Type': 'application/json',
          },
          body: body);
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
        await pref.setString('first_name', fn);
        String ln = utf8.decode(info['last_name'].toString().codeUnits);
        await pref.setString('last_name', ln);
        await pref.setString('mode', info['mode']);
        await (info['birth_date'] != null)
            ? pref.setString('birth_date', info['birth_date'])
            : pref.setString('birth_date', "");
        await pref.setString('gender', info['gender']);

        // fixe if user enter arabic bio
        String bio = utf8.decode(info['bio'].toString().codeUnits);
        await (info['bio'] != null)
            ? pref.setString('bio', bio)
            : pref.setString('bio', "");
        (info['average_fast_answer'] != null)
            ? await pref.setString('answer_speed', info['average_fast_answer'])
            : await pref.setString('answer_speed', "");
        (info['clients_number'] != null)
            ? await pref.setInt('clients_number', info['clients_number'])
            : await pref.setInt('clients_number', 0);
        (info['services_number'] != null)
            ? await pref.setInt('services_number', info['services_number'])
            : await pref.setInt('services_number', 0);
        (info['average_rating'] != null)
            ? await pref.setDouble('rating', info['average_rating'])
            : await pref.setDouble('rating', 0.0);
        String an = utf8.decode(info['area_name'].toString().codeUnits);
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

  Future<List?> getCategories() async {
    try {
      Response response =
          await get(Uri.parse(Server.host + Server.listCategories));
      List finalCat = [];
      if (response.statusCode == 200) {
        var cate = jsonDecode(response.body);
        print(cate);
        List os = cate;
        for (int i = 0; i < os.length; i++) {
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

  Future<List?> createServeice(
      var titleController,
      var descriptionController,
      var priceController,
      var type,
      var areaList,
      var formList,
      var user) async {
    try {
      List toJson(var list) {
        List<Map<String, dynamic>> op = [];
        for (int i = 0; i < 4; i++) {
          op.add({
            "title": "${list[i][0].text}",
            "field_type": (list[i][1].text == "نص") ? "text" : "number",
            "note": ""
          });
        }
        for (int i = 4; i < list.length; i++) {
          op.add({
            "title": "${list[i][0].text}",
            "field_type": "${list[i][1]}",
            "note": "${list[i][2].text}"
          });
        }
        return op;
      }

      var os = toJson(formList);
      Map<String, dynamic> finalObject() {
        return {
          "title": titleController.text,
          "description": descriptionController.text,
          "category": type,
          "average_price_per_hour": priceController.text,
          "service_area": areaList,
          "form": os,
        };
      }

      final body = jsonEncode(finalObject());
      Response response =
          await post(Uri.parse(Server.host + Server.createService),
              headers: {
                "Authorization": 'token ${user.token}',
                'Content-Type': 'application/json',
              },
              body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var info = jsonDecode(response.body);
        var yes = [info["title"]];
        return yes;
      } else {
        var no = [];
        print(response.statusCode);
        print(jsonDecode(response.body));
        return no;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List?> listMyServices(var user) async {
    try {
      Response response = await get(Uri.parse(
          '${Server.host}${Server.listMyService}?username=${user.userName}'));
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        List os = info;
        List services = [];
        for (int i = 0; i < os.length; i++) {
          List<Area> area = [];
          Category ob = Category(info[i]["category"]['id'],
              utf8.decode(info[i]["category"]['name'].toString().codeUnits));
          for (int j = 0; j < info[i]["service_area"].length; j++) {
            Area o = Area(info[i]["service_area"][j]['id'],
                utf8.decode(info[i]["service_area"][j]['name'].toString().codeUnits));
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
              area);*/
          services.add(service);
        }
        return services;
      } else {
        List op = [];
        return op;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List?> myServiceDetail(int id) async {
    try {
      Response response =
          await get(Uri.parse('${Server.host}${Server.serviceDetails}$id'));
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        List services = [];
        List<Area> area = [];
        Category ob = Category(info["category"]['id'],
            utf8.decode(info["category"]['name'].toString().codeUnits));
        for (int j = 0; j < info["service_area"].length; j++) {
          Area o = Area(
              info["service_area"][j]['id'],
              utf8.decode(info["service_area"][j]['name'].toString().codeUnits));
          area.add(o);
        }
        ServiceDetails service = ServiceDetails(
            info['id'],
            utf8.decode(info["title"].toString().codeUnits),
            info["average_ratings"],
            utf8.decode(
                info["seller"]["user"]["first_name"].toString().codeUnits),
            utf8.decode(
                info["seller"]["user"]["last_name"].toString().codeUnits),
            info["seller"]["user"]["username"],
            info["average_price_per_hour"],
            ob,
            area,
            info["seller"]["user"]["photo"],
            info["number_of_served_clients"],
            utf8.decode(info["description"].toString().codeUnits));
        services.add(service);
        return services;
      } else {
        print(jsonDecode(response.body));
        List op = [];
        return op;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List?> deleteService(int id, var user) async {
    try {
      Response response = await delete(
          Uri.parse("${Server.host}${Server.deleteService}$id"),
          headers: {
            "Authorization": 'token ${user.token}',
          });
      if (response.statusCode == 204) {
        print("kakakakakaka");
        //print(jsonDecode(response.body));
        List op = [];
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = ['error'];
        return op;
      }
    } catch (e) {}
  }

  Future<List?> getServiceFroms(int id, var user) async {
    try {
      Response response = await get(
          Uri.parse('${Server.host}${Server.getServiceForm}$id'),
          headers: {
            "Authorization": 'token ${user.token}',
          });
      if (response.statusCode == 200) {
        List op = [];
        var info = jsonDecode(response.body);
        List os = info;
        for (int i = 0; i < os.length; i++) {
          List item = [];
          item.add(utf8.decode(info[i]["title"].toString().codeUnits));
          (info[i]["field_type"] == "text") ? item.add("نص") : item.add("رقم");
          item.add(utf8.decode(info[i]["note"].toString().codeUnits));
          op.add(item);
        }
        return op;
      }

      List op = [];
      return op;
    } catch (e) {
      print(e);
    }
  }

  Future<List?> updateService(var titleController, var descriptionController,
      var priceController, var areaList, var formList, var user, int id) async {
    bool firstFunction = false;
    bool secondFunction = false;

    try {
      Map<String, dynamic> toJson() {
        return {
          "title": titleController.text,
          "description": descriptionController.text,
          "average_price_per_hour": priceController.text,
          "service_area": areaList
        };
      }
      print(areaList);
      final body = jsonEncode(toJson());
      Response response = await put(
          Uri.parse('${Server.host}${Server.updateServiceMainData}$id'),
          headers: {
            "Authorization": 'token ${user.token}',
            'Content-Type': 'application/json'
          },
          body: body);
      if (response.statusCode == 200) {
        firstFunction = true;
      } else {
        print("aaaaaaaaaaaaaaaaaaaaaaaaa");
        print(response.statusCode);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    // second function
    try {
      List toJson(var list) {
        List<Map<String, dynamic>> op = [];
        for (int i = 0; i < 4; i++) {
          op.add({
            "title": "${list[i][0]}",
            "field_type": (list[i][1] == "نص") ? "text" : "number",
            "note": ""
          });
        }
        for (int i = 4; i < list.length; i++) {
          op.add({
            "title": "${list[i][0].text}",
            "field_type": "${list[i][1]}",
            "note": "${list[i][2].text}"
          });
        }
        return op;
      }

      final body = jsonEncode(toJson(formList));
      Response response = await put(
          Uri.parse('${Server.host}${Server.updateServiceForm}$id'),
          headers: {
            "Authorization": 'token ${user.token}',
            'Content-Type': 'application/json'
          },
          body: body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        secondFunction = true;
      } else {
        print("bbbbbbbbbbbbbbbbbbbbbbbb");
        print(response.statusCode);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    if (firstFunction && secondFunction) {
      List oo = [];
      return oo;
    } else {
      print("nop");
      List oo = ["no"];
      return oo;
    }
  }

  Future<List<Order?>> getMySentOrder(var user) async {
    try {
      Response response = await get(Uri.parse(Server.host + Server.mySentOrder),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        print(response.statusCode);
        List<Order?> finalData = [];
        List os = info;
        for (int i = 0; i < os.length; i++) {
          List<Area> serviceArea = [];
          Category category = Category(
              info[i]["home_service"]["category"]["id"],
              utf8.decode(info[i]["home_service"]["category"]["name"]
                  .toString()
                  .codeUnits));
          for (int j = 0; j < info[i]["home_service"]["service_area"].length; j++) {
            Area o = Area(
              info[i]["home_service"]["service_area"][j]['id'],
              utf8.decode(info[i]["home_service"]["service_area"][j]['name']
                  .toString()
                  .codeUnits),
            );
            serviceArea.add(o);
          }
          Service homeService = Service.orderService(
              utf8.decode(info[i]["home_service"]["title"].toString().codeUnits),
              (info[i]["home_service"]["seller"]!= null)?info[i]["home_service"]["seller"]:"",
              category,
              (info[i]["home_service"]["average_price_per_hour"]!= null )?info[i]["home_service"]["average_price_per_hour"]:"",
              serviceArea);
          List<Form1> orderForm = [];
          for (int j = 0; j < info[i]["form"].length; j++) {
            Field o = Field(
                utf8.decode(
                    info[i]['form'][j]['field']['note'].toString().codeUnits),
                utf8.decode(
                    info[i]['form'][j]['field']['title'].toString().codeUnits),
                info[i]['form'][j]['field']["field_type"]);
            Form1 oo = Form1(
                o,
                utf8.decode(info[i]['form'][j]["content"].toString().codeUnits));
            orderForm.add(oo);
          }

          Order order = Order(
              info[i]['id'],
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(info[i]["create_date"])),
              info[i]["status"],
              homeService,
              info[i]["client"]["username"],
              orderForm,
              "",
              (info[i]["is_rateable"] == null) ? false : info[i]["is_rateable"],
              info[i]["expected_time_by_day_to_finish"],
              utf8.decode(info[i]["client"]["last_name"].toString().codeUnits),
              utf8.decode(info[i]["client"]["first_name"].toString().codeUnits),
              utf8.decode(info[i]["seller"]["first_name"].toString().codeUnits),
              utf8.decode(info[i]["seller"]["last_name"].toString().codeUnits),
              utf8.decode(info[i]["seller"]["photo"].toString().codeUnits),
            info[i]["seller"]["username"],
          );
          finalData.add(order);
        }
        return finalData;
      } else {
        print('fuck');
        print(response.statusCode);
        print(jsonDecode(response.body));
        List<Order?> op = [];
        return op;
      }
    } catch (e) {
      print(e);
      List<Order?> op = [];
      return op;
    }
  }

  Future<List?> cancelOrder(int id, var user) async {
    try {
      Response response = await delete(
          Uri.parse('${Server.host}${Server.deleteOrder}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 204) {
        print(response.statusCode);
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        List op = [];
        return op;
      }
    } catch (e) {}
  }

  Future<List<Order?>> receivedOrder(var user) async {
    try {
      Response response = await get(
          Uri.parse(Server.host + Server.myReceivedOrder),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        List<Order?> finalData = [];
        List os = info;
        for (int i = 0; i < os.length; i++) {
          List<Area> serviceArea = [];
          Category category = Category(
              info[i]["home_service"]["category"]["id"],
              utf8.decode(info[i]["home_service"]["category"]["name"]
                  .toString()
                  .codeUnits));
          for (int j = 0; j < info[i]["home_service"]["service_area"].length; j++) {
            Area o = Area(
              info[i]["home_service"]["service_area"][j]['id'],
              utf8.decode(info[i]["home_service"]["service_area"][j]['name']
                  .toString()
                  .codeUnits),
            );
            serviceArea.add(o);
          }
          Service homeService = Service.orderService(
              utf8.decode(
                  info[i]["home_service"]["title"].toString().codeUnits),
              (info[i]["home_service"]["seller"]!=null)?info[i]["home_service"]["seller"]:"",
              category,
              info[i]["home_service"]["average_price_per_hour"],
              serviceArea);
          List<Form1> orderForm = [];
          for (int j = 0; j < info[i]["form"].length; j++) {
            Field o = Field(
                utf8.decode(info[i]['form'][j]['field']['note'].toString().codeUnits),
                utf8.decode(info[i]['form'][j]['field']['title'].toString().codeUnits),
                info[i]['form'][j]['field']["field_type"]);
            Form1 oo = Form1(
                o,
                utf8.decode(
                    info[i]['form'][j]["content"].toString().codeUnits));
            orderForm.add(oo);
          }
          Order order = Order(
            info[i]['id'],
            DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(info[i]["create_date"])),
            info[i]["status"],
            homeService,
            info[i]["client"]["username"],
            orderForm,
            "",
            (info[i]["is_rateable"] == null) ? false : info[i]["is_rateable"],
            info[i]["expected_time_by_day_to_finish"],
            utf8.decode(info[i]["client"]["last_name"].toString().codeUnits),
            utf8.decode(info[i]["client"]["first_name"].toString().codeUnits),
            utf8.decode(info[i]["seller"]["first_name"].toString().codeUnits),
            utf8.decode(info[i]["seller"]["last_name"].toString().codeUnits),
            utf8.decode(info[i]["seller"]["photo"].toString().codeUnits),
            info[i]["seller"]["username"],
          );
          finalData.add(order);
        }
        return finalData;
      } else {
        print('fuck');
        print(response.statusCode);
        print(jsonDecode(response.body));
        List<Order?> op = [];
        return op;
      }
    } catch (e) {
      print(e);
      List<Order?> op = [];
      return op;
    }
  }

  Future<List?> firstReject(int id, var user) async {
    try {
      Response response = await put(
          Uri.parse('${Server.host}${Server.firstRejectForOrder}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 204) {
        print(response.statusCode);
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        List op = [];
        return op;
      }
    } catch (e) {}
  }

  Future<List<Form1>> firstAccept(int id, var user) async {
    try {
      Response response = await put(
          Uri.parse('${Server.host}${Server.firstAcceptanceForOrder}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        print(response.statusCode);
        List<Form1> op = [];
        var info = jsonDecode(response.body);
        List o = info;
        for (int i = 0; i < o.length; i++) {
          Field ob = Field(
              (info[i]["field"]["note"] != null)
                  ? utf8.decode(info[i]["field"]["note"].toString().codeUnits)
                  : "",
              (info[i]["field"]["note"] != null)
                  ? utf8.decode(info[i]["field"]["title"].toString().codeUnits)
                  : "",
              info[i]["field"]["field_type"]);
          Form1 ob1 = Form1(
            ob,
            (info[i]["content"] != null)
                ? utf8.decode(info[i]["content"].toString().codeUnits)
                : "",
          );
          op.add(ob1);
        }
        return op;
      } else {
        print(response.statusCode);
        List<Form1> op = [];
        return op;
      }
    } catch (e) {
      print(e);
      List<Form1> op = [];
      return op;
    }
  }

  Future<List?> rejectAfterReview(int id, var user) async {
    try {
      Response response = await put(
          Uri.parse('${Server.host}${Server.rejectOrderAfterReview}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        print(response.statusCode);
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        List op = [];
        return op;
      }
    } catch (e) {}
  }

  Future<List?> acceptAfterReview(int id, var user) async {
    try {
      Response response = await put(
          Uri.parse('${Server.host}${Server.acceptOrderAfterReview}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        print(response.statusCode);
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        List op = [];
        return op;
      }
    } catch (e) {
      print(e);
      List op = [];
      return op;
    }
  }

  Future<List?> finishOrder(int id, var user) async {
    try {
      Response response = await put(
          Uri.parse('${Server.host}${Server.finishOrder}$id'),
          headers: {"Authorization": 'token ${user.token}'});
      if (response.statusCode == 200) {
        print(response.statusCode);
        List op = ['done'];
        return op;
      } else {
        print(response.statusCode);
        List op = [];
        return op;
      }
    } catch (e) {}
  }

  Future<List<Rating>> getServiceAllRating(int id, var user) async {
    try {
      Response response = await get(
          Uri.parse("${Server.host}${Server.serviceAllRating}$id"),
          headers: {"Authorization": 'token ${user.token}'});
      List<Rating> rating = [];
      if (response.statusCode == 200) {
        print(response.statusCode);
        var info = jsonDecode(response.body);
        List op = info;
        for (int i = 0; i < op.length; i++) {
          Rating rate = Rating(
              info[i]["id"],
              utf8.decode(info[i]["client_comment"].toString().codeUnits),
              utf8.decode(info[i]["client"]["first_name"].toString().codeUnits),
              utf8.decode(info[i]["client"]["last_name"].toString().codeUnits),
              info[i]["client"]["photo"],
              info[i]["client"]["username"],
              info[i]["commitment_to_deadline"],
              info[i]["quality_of_service"],
              info[i]["rating_time"],
              (info[i]["seller_comment"] != null)
                  ? info[i]["seller_comment"]
                  : "",
              info[i]["work_ethics"]);

          rating.add(rate);
        }
        return rating;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List<Rating> os = [];
        return os;
      }
    } catch (e) {
      print(e);
      List<Rating> os = [];
      return os;
    }
  }

  Future<List<HomeServiceRating>> getAllMyRating(var user) async {
    try {
      Response response = await get(
          Uri.parse("${Server.host}${Server.allMyRating}${user.userName}"),
          //headers: {"Authorization": 'token ${user.token}'}
           );
      List<HomeServiceRating> rating = [];
      if (response.statusCode == 200) {
        print(response.statusCode);
        var info = jsonDecode(response.body);
        List op = info;
        for (int i = 0; i < op.length; i++) {
          HomeServiceRating rate = HomeServiceRating(
              info[i]["id"],
              utf8.decode(info[i]["client_comment"].toString().codeUnits),
              utf8.decode(info[i]["client"]["first_name"].toString().codeUnits),
              utf8.decode(info[i]["client"]["last_name"].toString().codeUnits),
              info[i]["client"]["photo"],
              info[i]["client"]["username"],
              info[i]["commitment_to_deadline"],
              info[i]["quality_of_service"],
              info[i]["rating_time"],
              (info[i]["seller_comment"] != null)
                  ? info[i]["seller_comment"]
                  : "",
              info[i]["work_ethics"],
              info[i]["home_service"]["id"],
              utf8.decode(
                  info[i]["home_service"]["title"].toString().codeUnits),
              utf8.decode(
                  info[i]["home_service"]["category"].toString().codeUnits));

          rating.add(rate);
        }
        return rating;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List<HomeServiceRating> os = [];
        return os;
      }
    } catch (e) {
      print(e);
      List<HomeServiceRating> os = [];
      return os;
    }
  }

  Future<List?> sendUserComment(var user, var orderId, int ethical,
      int deadLine, int quality, TextEditingController comment) async {
    try {
      print(orderId);
      print(ethical);
      print(deadLine);
      print(quality);
      print(comment.text);
      print(user.token);
      Response response = await post(
          Uri.parse("${Server.host}${Server.sendRate}$orderId"),
          headers: {
            "Authorization": 'token ${user.token}'
          },
          body: {
            "quality_of_service": quality.toString(),
            "commitment_to_deadline": deadLine.toString(),
            "work_ethics": ethical.toString(),
            "client_comment": comment.text.toString()
          });
      print("oooo");
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = [];
        return op;
      } else {
        print(response.statusCode);
        print(jsonDecode(response.body));
        List op = ['done'];
        return op;
      }
    } catch (e) {
      print(e);
      List op = ['done'];
      return op;
    }
  }

  Future<Tuple2<bool, List>> serchResult(String serachTarget) async {
    try {
      Response response = await get(
          Uri.parse(Server.host + Server.listMyService + serachTarget));
      if (response.statusCode == 200) {
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
      } else{
        print (response.statusCode);
        print (jsonDecode(response.body));
        bool status =false;
        List services = [];
        return Tuple2(status, services);
      }
    } catch (e) {
      print(e);
      bool status =false;
      List services = [];
      return Tuple2(status, services);
    }
  }

  // get seller user balance
  // we pass the user token and we get the seller user balance

  Future<Tuple2<bool,int>> getUserBalance (var user) async{
    try{
      Response response = await get(Uri.parse(Server.host+Server.userBalance),
        headers: {"Authorization": 'token ${user.token}'});
      if(response.statusCode == 200){
        print(response.statusCode);
        var info = jsonDecode(response.body);
        return Tuple2(true, info["total_balance"]);
      } else {
        print(response.statusCode);
        print (jsonDecode(response.body));
        return Tuple2(false, 0);
      }
    } catch (e) {
      print(e);
      return Tuple2(false, 0);
    }
  }

}
