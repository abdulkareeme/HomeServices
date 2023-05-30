import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: const [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/home1.jpg'),
                radius: 90,
              ),
            )
          ],
        ),
      ),
    );
  }
}
