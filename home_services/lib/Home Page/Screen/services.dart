import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/search/Widget/get_service_name_and_category_search_result.dart';
import 'package:home_services/user_profile/list_my_services/Widget/fetch_service_detail.dart';
import 'package:home_services/user_profile/list_my_services/Widget/service_item.dart';

// ignore: must_be_immutable
class Services extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var services, user,category;
  Services({Key? key,required this.services,required this.user,this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (services.length == 0)?const Center(child: Text("لا توجد خدمات بهذا الاسم",style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 28,
        color: Colors.black38
    ),),):Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text((category!=null)?category:""),
          backgroundColor: Colors.grey[700],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: MyFild(
                  contorller: searchController,
                  hintText: "",
                  obscure: false,
                  lable: const Text("اسم الخدمة"),
                  readOnly: false,
                  rightPadding: 20.0,
                  leftPadding: 20.0,
                  color: Colors.white,
                  sidesColor: Colors.black,
                  suffixIcon: IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetServiceNameAndCategorySearchResult(user: user, titleController: searchController, category: category)));
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              for(int i=0;i<services.length;i++)ServiceItem(service: services[i],user: user,onTap: (){
                if(services[i].creatorUserName!=user.userName){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                  userSellerCase: true,
                  id: services[i].id,
                  user: user,
                )));} else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                    userSellerCase: false,
                    id: services[i].id,
                    user: user,
                  )));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
