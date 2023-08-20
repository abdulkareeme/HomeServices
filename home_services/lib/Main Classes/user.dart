class User {
  late String
      firstName,
      lastName,
      userName,
      email,
      token,
      mode,
      gender,
      birthDate,
      joinDate,
      areaName,
      bio,
      photo;

  int areaId,id;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.token,
      this.mode,
      this.gender,
      this.birthDate,
      this.joinDate,
      this.areaName,
      this.bio,
      this.areaId,
      this.photo);

  factory User.noPhoto(String firstName, lastName, userName, email, token,
      mode, gender, birthDate, joinDate, areaName, bio,photo, int areaId,id) {
    return User(id, firstName, lastName, userName, email, token, mode, gender,
        birthDate, joinDate, areaName, bio, areaId,photo);
  }
}

class Seller extends User{
  int servicesNumber, clientsNumber;
  String averageFastAnswer;
  double averageRating;
  Seller(super.id, super.firstName, super.lastName, super.userName, super.email, super.token, super.mode, super.gender, super.birthDate, super.joinDate, super.areaName, super.bio, super.areaId, super.photo,this.averageFastAnswer,this.averageRating,this.clientsNumber,this.servicesNumber);
  factory Seller.noPhoto(int servicesNumber,id,clientsNumber,areaId,String
      firstName,
      lastName,
      userName,
      averageFastAnswer,
      email,
      token,
      mode,
      gender,
      birthDate,
      joinDate,
      areaName,
      bio,
      photo,
      double averageRating){
    return Seller(id, firstName, lastName, userName, email, token, mode, gender, birthDate, joinDate, areaName, bio, areaId, photo, averageFastAnswer, averageRating, clientsNumber, servicesNumber);
  }
}
