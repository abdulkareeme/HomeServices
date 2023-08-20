import 'area.dart';
import 'category.dart';

class Service{
  late int id,hourPrice;
  late double rating;
  late String title,creatorUserName,creatorFirstName,creatorLastName,photo;
  late Category category;
  late List<Area> areaList;
  Service(
      this.id,
      this.title,
      this.rating,
      this.creatorFirstName,
      this.creatorLastName,
      this.creatorUserName,
      this.hourPrice,
      this.category,
      this.areaList,
      this.photo
      );
  factory Service.orderService(
      String title,seller,
      Category category,
      int hourPrice,
      List<Area>areaList,
      ){
    return Service(0, title, 0.0, "", "", seller, hourPrice, category, areaList,"");
  }
}
class ServiceDetails extends Service{
  late int numberOfClients;
  late String description;
  ServiceDetails(
      super.id,
      super.title,
      super.rating,
      super.creatorFirstName,
      super.creatorLastName,
      super.creatorUserName,
      super.hourPrice,
      super.category,
      super.areaList,
      super.photo,
      this.numberOfClients,
      this.description);

}