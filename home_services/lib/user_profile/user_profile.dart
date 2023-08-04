import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Widget/user_profile_body.dart';
import 'package:home_services/user_profile/user_profile_drawer/user_profile_drawer.dart';
import 'dart:ui'as ui;
import 'package:image_picker/image_picker.dart';
import 'Api/User_Profile_Api.dart';
// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  int myBalance;
  UserProfile({
    required this.user,
    required this.myBalance,
    super.key,
});

  @override
  State<StatefulWidget> createState() => _UserProfileState();
  String mode = "دمشق";
  String gender = "female";

}
class _UserProfileState extends State<UserProfile> {
  Future imagePicker(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      print("no such image");
    }
  }
  Uint8List? myImage;
  void selectImage()async{
    Uint8List image =await imagePicker(ImageSource.gallery);
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
            backgroundColor: Colors.grey[700],
          ),
          drawer: Drawer(
            child: UserProfileDrawer(user: widget.user, height: constHeight, width: constWidth, myImage: myImage,myBalance: widget.myBalance,)
          ),
          body: UserProfileBody(user: widget.user, height: constHeight, width: constWidth, selectImageMethod: selectImage,myImage: myImage,myBalance:widget.myBalance ),
        ),
      ),
    );
  }
}
