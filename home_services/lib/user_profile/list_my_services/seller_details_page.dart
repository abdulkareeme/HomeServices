import 'package:flutter/material.dart';
import 'package:home_services/style/service_details_style.dart';
import '../../Main Classes/service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:home_services/user_profile/update_service/list_area.dart';
import 'delete_service.dart';

// ignore: must_be_immutable
class SellerServiceDetails extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ServiceDetails service;
  SellerServiceDetails({this.user,required this.service,super.key});

  @override
  Widget build(BuildContext context) {
    return (
        SafeArea(
          child: Directionality(
          textDirection: TextDirection.rtl,
           child: Scaffold(
             body:SingleChildScrollView(
                child:Column(
                  children: [
                    const SizedBox(height: 55,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: (user.gender == "Male")
                              ? const AssetImage('images/male.jpeg')
                              : const AssetImage('images/female.jpeg'),
                          radius: 60,
                        ),
                      ],
                    ),
                    Text("${service.creatorFirstName} ${service.creatorLastName}",style: ServiceDetailsStyle.fullNameStyle(),),
                    Text(service.creatorUserName,style: ServiceDetailsStyle.userNameStyle(),),
                    const SizedBox(height: 35,),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("شرح عن الخدمة : ")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(service.description),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25,right: 25),
                      child: Divider(
                        thickness: 1.2,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("تصنيف الخدمة : ",style: ServiceDetailsStyle.detailsStyle(),),
                          Text(service.category.name,style: ServiceDetailsStyle.detailsStyle(),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("متوسط اجر الساعة : ",style: ServiceDetailsStyle.detailsStyle(),),
                          Text("${service.hourPrice} ل.س ",style: ServiceDetailsStyle.detailsStyle(),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("متوسط سرعة الرد : ",style: ServiceDetailsStyle.detailsStyle(),),
                          Text("${(user.averageFastAnswer== "")?0:user.averageFastAnswer}",style: ServiceDetailsStyle.detailsStyle(),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("متوسط التقييمات : ",style: ServiceDetailsStyle.detailsStyle(),),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for(int i=0;i<service.rating.toInt();i++)const Icon(Icons.star,color: Colors.yellow,),
                              for(int i=0;i<5-service.rating.toInt();i++)const Icon(Icons.star_outline,color: Colors.yellow,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("عدد مشترين هذه الخدمة : ",style: ServiceDetailsStyle.detailsStyle(),),
                          Text(service.numberOfClients.toString(),style: ServiceDetailsStyle.detailsStyle(),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("مناطق تقديم هذه الخدمة : ",style: ServiceDetailsStyle.detailsStyle(),),
                        ],
                      ),
                    ),
                    Column(
                        children: [
                          Wrap(

                            spacing: 8.0, // space between tags
                            runSpacing: 4.0, // space between lines
                            children:  [
                              for(int i=0;i<service.areaList.length;i++)Chip(label: Text(service.areaList[i].name)),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 25,),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: (){},
                              child: const Text("حذف الخدمة",style: TextStyle(
                                  fontSize: 17
                              ),)),
                          const SizedBox(height: 20,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                padding: const EdgeInsets.all(10)/*only(left: MediaQuery.of(context).size.width/2.9,right: MediaQuery.of(context).size.width/2.9,top: 10,bottom: 10)*/,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: (){},
                              child: const Text("تعديل الخدمة",style: TextStyle(
                                  fontSize: 17
                              ))),
                        ],
                      ),
                    )*/
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.9,right: MediaQuery.of(context).size.width/2.9,top: 10,bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetListArea(service:service,user: user)));
                      },
                      child: const Text("تعديل الخدمة",style: TextStyle(
                          fontSize: 17
                      ))),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.9,right: MediaQuery.of(context).size.width/2.9,top: 10,bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: (){
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              title: "تحذير",
                              text: "هل ترغب بحذف خدمة  ${service.title}؟",
                              confirmBtnText: "تأكيد",
                              cancelBtnText: "إلغاء",
                              showCancelBtn: true,
                              confirmBtnColor: Colors.red,
                              onConfirmBtnTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeleteService(
                                  user: user,
                                  service: service,
                                )));
                              },
                              onCancelBtnTap: (){
                                Navigator.of(context).pop();
                              }
                          );
                        },
                        child: const Text("حذف الخدمة",style: TextStyle(
                            fontSize: 17
                        ),)),
                    const SizedBox(height: 30,)
                  ],

                )
             ),
            ),
      ),
    ));
  }
}
