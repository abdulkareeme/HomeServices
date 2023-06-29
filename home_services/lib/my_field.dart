import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFild extends StatefulWidget {
  final obscure;
  final hintText;
  final contorller;
  final lable;
  final val;
  final suffixIcon;
  final preffixIcon;
  final errorText;
  final color;
  final sidesColor;
  final keyboardType;
  final autoValidateMode;
  final onTap;
  bool readOnly;
  final maxLine;
  final maxLetters;
  final leftPadding;
  final rightPadding;
  MyFild(
      {super.key,
      required this.contorller,
      required this.hintText,
      required this.obscure,
      required this.lable,
      required this.readOnly,
      required this.rightPadding,
      required this.leftPadding,
      this.onTap,
      this.maxLine,
      this.maxLetters,
      this.preffixIcon,
      this.suffixIcon,
      this.autoValidateMode,
      this.errorText,
      this.val,
      required this.color,
      required this.sidesColor,
      this.keyboardType});

  @override
  State<MyFild> createState() => _MyFildState();
}

class _MyFildState extends State<MyFild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.leftPadding, right: widget.rightPadding),
      child: TextFormField(
          maxLines: widget.maxLine,
          maxLength: widget.maxLetters,
          keyboardType: widget.keyboardType,
          controller: widget.contorller,
          obscureText: widget.obscure,
          readOnly: widget.readOnly,
          autovalidateMode: widget.autoValidateMode,
          validator: widget.val,
          decoration: InputDecoration(
            prefixIcon: widget.preffixIcon,
            suffixIcon: widget.suffixIcon,
            errorText: widget.errorText,
            label: widget.lable,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            filled: true,
            fillColor: widget.color,
            //enabled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: widget.sidesColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: widget.sidesColor,
                  //width:2,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: widget.sidesColor
                    //width:2,
                    )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: widget.sidesColor
                    //width:2,
                    )),
          )),
    );
  }
}

