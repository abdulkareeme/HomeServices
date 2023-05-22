// ignore: avoid_web_libraries_in_flutter
//import 'dart:js';
import 'package:flutter/material.dart';


class SlideRight extends PageRouteBuilder {
  var page;

  SlideRight({
    this.page,
  }) :super(pageBuilder: (context, animation, animationTow) => page,
      transitionsBuilder: (context, animation, animationTow, child) {
        Offset begin = const Offset( 1,0);
        Offset end = const Offset(0,0);
        var tween =Tween( begin:begin ,end: end );
        var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.linear);
        return SlideTransition(position: tween.animate(curvesAnimation),child: child,);
      });
}