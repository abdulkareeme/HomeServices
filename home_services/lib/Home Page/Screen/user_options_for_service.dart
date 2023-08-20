import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Order%20Service/get_ordered_service_forms.dart';
import 'package:home_services/Home%20Page/Widget/get_user_details.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/style/service_details_style.dart';


class UserOptionForService extends StatelessWidget {
  ServiceDetails service;
  var user;
  UserOptionForService({Key? key,required this.service,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 55,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetUserDetails(username: service.creatorUserName)));
                      },
                      child: CircleAvatar(
                        backgroundImage:NetworkImage(service.photo),
                        radius: 60,
                      ),
                    ),
                  ],
                ),
                InkWell(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetUserDetails(username: service.creatorUserName)));
                },child: Text("${service.creatorFirstName} ${service.creatorLastName}",style: ServiceDetailsStyle.fullNameStyle(),)),
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.9,right: MediaQuery.of(context).size.width/2.9,top: 10,bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetOrderedServiceForm(
                      user:user,
                      id: service.id,
                    )));
                  },
                  child: const Text("شراء الخدمة",style: TextStyle(
                      fontSize: 17
                  )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
