import 'package:flutter/material.dart';

class LogInStyle {

  static ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(left: 100, right: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      primary: Colors.black,
    );
  }

  static TextStyle logInButtonTextStyle() {
    return (
        const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
        )
    );
  }

  static TextStyle forgetPasswordStyle() {
    return (
        const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
            decoration: TextDecoration.underline,
            decorationThickness: 1.7,
            fontSize: 17.3
        )
    );
  }

  static TextStyle alreadyHaveAccountStyle() {
    return (
        const TextStyle(

          fontSize: 17,
          fontWeight: FontWeight.w600,
        )
    );
  }

  static TextStyle signUpStyle(){
    return (
      const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        decoration: TextDecoration.underline,
        decorationThickness: 1.6,
      )
    );
  }

  static TextStyle errorStyle (){
    return(
    const TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 18,
      color: Colors.red,
    )
    );
  }

}