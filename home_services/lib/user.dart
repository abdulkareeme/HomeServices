class User {
   String userName,
      email,
      id,
      firstName,
      lastName,
      mode,
      joinDate,
      gender,
      areaName,
      token;
   int areaId;

  // ignore: prefer_typing_uninitialized_variables
  var birthDate, bio, photo;

  User({
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.id,
    required this.email,
    required this.gender,
    required this.mode,
    required this.userName,
    required this.areaId,
    required this.areaName,
    required this.token,
    this.birthDate,
    this.bio,
    this.photo,
  });
}

class Seller extends User {
  int clientNumber, serviceNumber;
  String averageFastAnswer;
  double averageRatting;

  Seller({
    required super.firstName,
    required super.lastName,
    required super.joinDate,
    required super.id,
    required super.email,
    required super.gender,
    required super.mode,
    required super.userName,
    required super.areaId,
    required super.areaName,
    required super.token,
    required this.averageFastAnswer,
    required this.averageRatting,
    required this.clientNumber,
    required this.serviceNumber,
  });

}
