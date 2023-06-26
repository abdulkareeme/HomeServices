import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Widget/get_area_list.dart';
import 'package:home_services/user_profile/create_new_service/create_new_service_page.dart';
import 'package:home_services/user_profile/create_new_service/list_categories.dart';
import 'package:home_services/user_profile/update_profile/get_area_list.dart';
import '../../Home Page/Drawer/Widget/drawer_components.dart';
import '../my_services_requests/my_requests.dart';

// ignore: must_be_immutable
class UserProfileDrawer extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user,width,height,myImage;
  UserProfileDrawer({
    required this.user,
    required this.height,
    required this.width,
    required this.myImage,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _UserProfileDrawerState();
}

class _UserProfileDrawerState extends State<UserProfileDrawer>{
  @override
  Widget build(BuildContext context) {
    var constWidth = widget.width;
    var constHeight = widget.height;
    return Column(
      children: [
        UserAccountsDrawerHeader(
            currentAccountPicture: (widget.myImage != null)? CircleAvatar(
              radius: 90,
              backgroundImage: MemoryImage(widget.myImage!),
            ): CircleAvatar(
                backgroundImage:(widget.user.gender == "Male")? const AssetImage('images/male.jpeg'):const AssetImage('images/female.jpeg') ),
            accountName: Text(widget.user.firstName +" "+ widget.user.lastName),
            accountEmail:Text(widget.user.email)
        ),
        Visibility(
          visible: (widget.user.mode == "client")? false :true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "إضافة خدمة جديدة",
                color: Colors.black,
                icon: Icons.add_box,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const GetCategoriesList()/*CreateNewService()*/));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "تعديل الملف الشخصي",
                color: Colors.black,
                icon: Icons.edit,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetAreaList1(user:widget.user)));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible:(widget.user.mode == "client")? false :true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "خدماتي",
                color: Colors.black,
                icon: Icons.sensors_rounded,
                onTap: (){

                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible:(widget.user.mode == "client") ? false : true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "تقيماتي",
                color: Colors.black,
                icon: Icons.rate_review,
                onTap: (){

                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible: (widget.user.mode == "client")? false :true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "الطلبات الواصلة",
                color: Colors.black,
                icon: Icons.local_offer,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyRequests()));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        const Divider(
          thickness: 0.5,
          color: Colors.black,
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "تسجيل خروج",
                color: Colors.black,
                icon: Icons.logout,
                onTap: (){

                },
                iconColor: Colors.blueGrey),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }


}