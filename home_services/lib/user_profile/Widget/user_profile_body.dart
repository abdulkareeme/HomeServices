import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../style/user_profile_style.dart';

// ignore: must_be_immutable
class UserProfileBody extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user,width,height,selectImageMethod,myImage;
  int myBalance;
  UserProfileBody({
    required this.user,
    required this.height,
    required this.width,
    required this.selectImageMethod,
    required this.myImage,
    required this.myBalance,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody>{

  @override
  Widget build(BuildContext context) {
    var constHeight = widget.height;
    return(
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: constHeight / 14,
              ),
              Center(
                child: InkWell(
                  onTap:widget.selectImageMethod,
                  child: (widget.myImage != null)? CircleAvatar(
                  radius: 90,
                  backgroundImage: MemoryImage(widget.myImage!),
                ): CircleAvatar(
                  backgroundImage:NetworkImage(widget.user.photo),
                  radius: 90,
                ),
                ),
              ),
              SizedBox(
                height: constHeight / 37,
              ),
              Text(
                widget.user.firstName +" "+ widget.user.lastName,
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
                    (widget.user.mode == "client")?"مستخدم":"بائع",
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
                    widget.user.areaName,
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
                    "تاريخ التسجيل ${DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(widget.user.joinDate))}",
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
                      Text(widget.user.bio,style: UserProfileStyle.bioStyle(),)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

}