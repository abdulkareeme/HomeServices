import 'package:flutter/material.dart';
import 'package:home_services/Log%20out/Widget/log_out.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/get_my_received_orders.dart';
import 'package:home_services/user_profile/Sent%20Orders/Widget/get_my_sent_order.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';
import 'package:home_services/user_profile/list_my_services/Widget/fetch_data.dart';
import 'package:home_services/user_profile/rating/Widget/get_my_all_rating.dart';
import 'package:home_services/user_profile/update_profile/Widget/get_area_list.dart';
import '../../Home Page/Drawer/Widget/drawer_components.dart';

// ignore: must_be_immutable
class UserProfileDrawer extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user,width,height,myImage;
  int myBalance;
  UserProfileDrawer({
    required this.user,
    required this.height,
    required this.width,
    required this.myImage,
    required this.myBalance,
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
          decoration:BoxDecoration(
            color: Colors.grey[700]
          ),
            currentAccountPicture: (widget.myImage != null)? CircleAvatar(
              radius: 90,
              backgroundImage: MemoryImage(widget.myImage!),
            ): CircleAvatar(
                backgroundImage:NetworkImage(widget.user.photo) ),
            accountName: Text(widget.user.firstName +" "+ widget.user.lastName),
            accountEmail:Text(widget.user.email),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GetCategoriesList(user: widget.user,op: false,)/*CreateNewService()*/));
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyServiceFetchData(user: widget.user)));
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetMyAllRating(user: widget.user,)));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible: true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "الطلبات المرسلة",
                color: Colors.black,
                icon: Icons.send,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetMySentOrder(user: widget.user)));
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetMyReceivedOrder(user: widget.user,isItUnderWay: false,)));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        Visibility(
          visible: (widget.user.mode == "client")? false :true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/20 ,bottom: constHeight/60 ,top: constHeight/60),
            child:Drawer_component(
                text: "الطلبات قيد التنفيذ",
                color: Colors.black,
                icon: Icons.approval_sharp,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetMyReceivedOrder(user: widget.user,isItUnderWay: true,)));
                },
                iconColor: Colors.blueGrey),
          ),

        ),
        Visibility(
          visible: (widget.user.mode == "client")? false :true,
          child: Padding(
            padding: EdgeInsets.only(right:constWidth/2.5),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("رصيدي : ${widget.myBalance} ل.س",style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                ),),
              ],
            ),
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogOut(user: widget.user)));
                },
                iconColor: Colors.blueGrey),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }


}