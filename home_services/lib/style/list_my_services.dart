import 'package:flutter/material.dart';

class ListMyServicesStyle{

  static TextStyle titleStyle(){
    return (
      const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      )
    );
  }
  static TextStyle categoryStyle(){
    return (
        const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400
        )
    );
  }
  static TextStyle priceStyle(){
    return (
        const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
        )
    );
  }
  static TextStyle priceWordStyle(){
    return (
        const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400
        )
    );
  }
}