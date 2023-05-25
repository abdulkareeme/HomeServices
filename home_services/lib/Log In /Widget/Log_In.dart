import 'package:flutter/material.dart';
import '../../Sign up/Widget/first_page_of_signup.dart';
import 'Log_In_button_and_field.dart';
import 'package:home_services/style/log_in_style.dart';

class LogIn extends StatefulWidget {
  String error;
  LogIn({required this.error,super.key,});

  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  List op = ['Lattakia','Damascus','aleppo','Hama','tartous','raqa','hasaka','Homes'];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double usedHeight = MediaQuery.of(context).padding.top;
    double leftSpace = height - usedHeight;
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: width,
                height: height,
                color: Colors.yellow,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Log in button and field
                  Expanded(child: LogInButtonAndField(height: height,loginError: widget.error,)),

                  //SizedBox(height: leftSpace,),
                  // already have account option
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "already have account ? ",
                          style: LogInStyle.alreadyHaveAccountStyle(),
                        ),
                        InkWell(
                          onTap:(){

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=> FirstPageOfSignUp(areaList: op,)));
                          },focusColor: Colors.black,
                          child:Text("Sign up",style: LogInStyle.signUpStyle(),) ,)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}