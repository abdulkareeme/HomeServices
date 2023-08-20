import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Drawer/Screen/home_page_drawer.dart';
import 'package:home_services/Home%20Page/Widget/carousel_slider_component.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/search/Widget/get_service_name_search_result.dart';
import 'package:home_services/user_profile/list_my_services/Widget/fetch_service_detail.dart';
import 'package:home_services/user_profile/list_my_services/Widget/service_item.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {

  // ignore: prefer_typing_uninitialized_variables
  var user;
  List category;
  List? services;
  int sellerBalance;
  HomePage({
    required this.user,
    required this.category,
    required this.services,
    required this.sellerBalance,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List carouselComponents = [
    CarouselSliderComponent(text: "", imageUrl: "images/logo-black.png"),
    CarouselSliderComponent(text: "توفير جميع الخدمات المنزلية       ", imageUrl:"images/services.jpeg"),
    CarouselSliderComponent(text: "اختيار افضل مقدمي الخدمات بناء على تقييمات اعمالهم", imageUrl: "images/rating.jpeg")
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.grey[700],
              title: const Text("الصفحة الرئيسية"),
            ),
            drawer: Drawer(
              child: Drawer_(user: widget.user,category: widget.category,myBalance: widget.sellerBalance),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [

                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16/15,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: carouselComponents.map((i) {
                      return Container(
                        width: 500,
                        child: i,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 45,),
                  MyFild(
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetServiceNameSearchResult(user: widget.user,titleController: searchController,)));
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("الخدمات الاكثر طلبا : ",style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic
                      ),),
                      for(int i=0;i<widget.services!.length;i++)Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10,bottom: 13,top: 15),
                      child: ServiceItem(service: widget.services![i],user: widget.user,onTap: (){
                          if(widget.services![i].creatorUserName!=widget.user.userName){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                              userSellerCase: true,
                              id: widget.services![i].id,
                              user: widget.user,
                            )));} else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FetchServiceDetails(
                              userSellerCase: false,
                              id: widget.services![i].id,
                              user: widget.user,
                            )));
                          }
                        }),
                      ),
                    ],
                  )
                  /*Center(
                    child: ElevatedButton(
                      onPressed: ()async{
                        LogOutApi op = LogOutApi();
                        //print(widget.user.token);
                        op.logOut();
                      },
                      child: const Text("clear data"),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        )
    );
  }


}