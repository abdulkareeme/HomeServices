import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class Drawer_component extends StatefulWidget {
  String text;
  var icon;
  Color color;
  Color iconColor;
  var onTap;
  Drawer_component({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap,
    required this.iconColor,
  });

  @override
  State<StatefulWidget> createState() => Drawer_component_State();
}

// ignore: camel_case_types
class Drawer_component_State extends State<Drawer_component> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(widget.icon,color: widget.iconColor,),
          const SizedBox(width: 10,),
          Text(widget.text,style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: widget.color
          ),),
        ],
      ),
    );
  }
}
