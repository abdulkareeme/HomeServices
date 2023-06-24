import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:home_services/style/user_profile_style.dart';
import 'package:home_services/Home Page/Drawer/Widget/drawer_components.dart';
import 'package:home_services/user_profile/Widget/user_profile_body.dart';
import 'package:home_services/user_profile/my_services_requests/my_requests.dart';
import 'package:home_services/user_profile/user_profile_drawer/user_profile_drawer.dart';
import 'dart:ui'as ui;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/update_profile/update_user_info.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  var user;
  UserProfile({
    required this.user,
    super.key,
});

  @override
  State<StatefulWidget> createState() => _UserProfileState();
  String mode = "دمشق";
  String gender = "female";

}
class _UserProfileState extends State<UserProfile> {
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
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.user.firstName +" "+ widget.user.lastName),
          ),
          drawer: Drawer(
            child: UserProfileDrawer(user: widget.user, height: constHeight, width: constWidth, myImage: myImage)
          ),
          body: UserProfileBody(user: widget.user, height: constHeight, width: constWidth, selectImageMethod: selectImage),
        ),
      ),
    );
  }
}
