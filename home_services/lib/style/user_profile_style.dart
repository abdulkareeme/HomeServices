import 'package:flutter/material.dart';

class UserProfileStyle{
  static TextStyle usernameStyle(){
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle locationStyle(){
    return const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400
    );
  }
  static TextStyle bioTitleStyle(){
    return const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600
    );
  }
  static TextStyle bioStyle(){
    return const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        wordSpacing: 1.5
    );
  }
}