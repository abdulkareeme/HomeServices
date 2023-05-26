import 'package:flutter/material.dart';

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

  MyFild(
      {super.key,
      required this.contorller,
      required this.hintText,
      required this.obscure,
      required this.lable,
      required this.readOnly,
      this.onTap,
      this.preffixIcon,
      this.suffixIcon,
      this.autoValidateMode,
      this.errorText,
      this.val,
      this.color,
      this.sidesColor,
      this.keyboardType});

  @override
  State<MyFild> createState() => _MyFildState();
}

class _MyFildState extends State<MyFild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
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
