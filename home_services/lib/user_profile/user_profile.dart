import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:home_services/style/user_profile_style.dart';
import 'package:home_services/Home Page/Drawer/Widget/drawer_components.dart';
import 'package:home_services/user_profile/my_services_requests/my_requests.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/update_profile/update_user_info.dart';
// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
   UserProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserProfileState();
  String mode = "seller";
  String gender = "female";

  String op1 = "api/update_profile/";
  String token = "875a1a467def8cc1bac47d29266053b1319acac0e4afde8428f358c9953b54d3";
   Map <String,dynamic> op = {
     'first_name' : "Abd Alhadi",
     'last_name' : "Abu Alshamat",
     'birt_date' : "2023-05-31",
     'area' : '1'
   };
}
class _UserProfileState extends State<UserProfile> {
  Future op()async{
    try{
      final os = jsonEncode(widget.op);
      Response response =await put(Uri.parse("http://abdulkareemedres.pythonanywhere.com/api/update_profile/"),headers: {
        'Authorization': 'token ${widget.token}',
      },body: {
        "bio": 'oppopop',
        "user": os,
      }
      );
      print('hellllllllllllllo');
    } catch(e){
      print(e);
    }

  }
  Uint8List? myImage;
  void selectImage()async{
    Uint8List image =await ProfileApi.imagePicker(ImageSource.gallery);
    setState(() {
      myImage = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    double constHeight = MediaQuery.of(context).size.height;
    double constWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("عبد الهادي ابو الشامات"),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                   UserAccountsDrawerHeader(
                    currentAccountPicture: (myImage != null)? CircleAvatar(
                      radius: 90,
                      backgroundImage: MemoryImage(myImage!),
                    ): CircleAvatar(
                        backgroundImage:(widget.gender == "male")? const AssetImage('images/male.jpeg'):const AssetImage('images/female.jpeg') ),
                    accountName: const Text("عبد الهادي ابو الشامات "),
                    accountEmail: const Text("abode2001a123@gmail.com")
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateUserInfo()));
                      },
                     iconColor: Colors.blueGrey),
                  ),
                ),
                Visibility(
                  visible:(widget.mode == "client")? false :true,
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
                  visible:(widget.mode == "client") ? false : true,
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
                  visible: true,
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
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: constHeight / 14,
                ),
                 Center(
                  child: InkWell(
                  onTap: (){
                    selectImage();
                  }
                  , child: (myImage != null)? CircleAvatar(
                      radius: 90,
                      backgroundImage: MemoryImage(myImage!),
                     ): CircleAvatar(
                      backgroundImage:(widget.gender == "male")? const AssetImage('images/male.jpeg'):const AssetImage('images/female.jpeg'),
                      radius: 90,

                    ),
                  ),
                ),
                SizedBox(
                  height: constHeight / 37,
                ),
                Text(
                  "عبد الهادي ابو الشامات",
                  style: UserProfileStyle.usernameStyle(),
                ),
                SizedBox(
                  height: constHeight / 45,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "بائع",
                      style: UserProfileStyle.locationStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: constHeight / 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "متواجد في مخبر الزلم",
                      style: UserProfileStyle.locationStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: constHeight / 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "تاريخ التسجيل 2021/4/5",
                      style: UserProfileStyle.locationStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: constHeight / 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      Text(
                        "نبذة عني :",
                        style: UserProfileStyle.bioTitleStyle(),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Divider(
                    color: Colors.black45,
                    thickness: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33,right: 33),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Text('انا مهندس برمجيات اجيد التعامل مع ال data base و برمجة التطبيقات باستخدام flutter و ال react native مع خبرة عالية في ال problem solving باستخدام لغة بالرمجة c++ او ال java',style: UserProfileStyle.bioStyle(),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
