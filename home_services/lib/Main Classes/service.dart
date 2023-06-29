import 'area.dart';
import 'category.dart';

class Service{
  late int id,hourPrice,rating;
  late String title,creatorUserName,creatorFirstName,creatorLastName;
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
      );
}