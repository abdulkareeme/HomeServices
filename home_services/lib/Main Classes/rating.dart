class Rating{

  late int id;
  late double qualityOfService,commitmentToDeadline,workEthics;
  late String clientComment,sellerComment,rattingTime,clientFirstName,clientLastName,clientUserName,photo;
  Rating(
      this.id,
      this.clientComment,
      this.clientFirstName,
      this.clientLastName,
      this.photo,
      this.clientUserName,
      this.commitmentToDeadline,
      this.qualityOfService,
      this.rattingTime,
      this.sellerComment,
      this.workEthics
      );

}

class HomeServiceRating extends Rating{
  late String homeServiceTitle,category;
  late int homeServiceId;

  HomeServiceRating(super.id, super.clientComment, super.clientFirstName, super.clientLastName, super.photo, super.clientUserName, super.commitmentToDeadline, super.qualityOfService, super.rattingTime, super.sellerComment, super.workEthics,this.homeServiceId,this.homeServiceTitle,this.category);

}