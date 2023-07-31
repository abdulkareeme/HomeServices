import 'package:flutter/material.dart';

class FirstSignupPageStyle{

  static ButtonStyle nextButtonStyle(){
    return(
      ElevatedButton.styleFrom(
        primary: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.only(top: 7,bottom: 7,right: 35,left: 35)
      )
    );
  }

  static TextStyle nextTextStyle(){
    return(
       const TextStyle(
        color: Colors.white,
        fontSize: 20,
      )
    );

  }

}