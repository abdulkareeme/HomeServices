import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/Main Classes/form.dart';
class Order{
  late int id,deadLine;
  late String createDate,status,clientName,photo;
  late Service homeService;
  late List<Form1> formList;
  late bool isRateable;
  Order(
      this.id,
      this.createDate,
      this.status,
      this.homeService,
      this.clientName,
      this.formList,
      this.photo,
      this.isRateable,
      this.deadLine,
      );
}