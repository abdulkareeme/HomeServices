import 'package:flutter/material.dart';

class CodeVerificationPageStyle{

  static TextStyle mainText(){
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
  }
  static TextStyle secondaryText(){
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );
  }
  static ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(left: 50, right: 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      primary: Colors.lightBlueAccent,
    );
  }
  static TextStyle resendCondeText(){
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.blue,
    );
  }
  static TextStyle checkForResendText(){
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: Colors.black
    );
  }
  static TextStyle buttonText(){
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: Colors.white,
    );
  }
}