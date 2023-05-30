import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/home_page.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../Sign up/Widget/code_verification_page.dart';
import '../../style/on_boarding_screen_style.dart';

class OnBoardingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _OnBoardingScreenState();
  String error = "";
  List op =[];
}

class _OnBoardingScreenState extends State<OnBoardingScreen>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to our app ",
            body: "our feature are the best",
          ),
          PageViewModel(
            title: "Welcome to our app ",
            body: "our feature are the best",
          ),
          PageViewModel(
            title: "Welcome to our app ",
            body: "our feature are the best",
          ),
          PageViewModel(
            title: "Welcome to our app ",
            body: "our feature are the best",
          ),
        ],
        done: Text("Done",style: OnBoardingScreenStyle.doneButtonStyle(),),
        onDone: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage(userInfo: widget.op)));
        },
        skip: Text("Skip",style: OnBoardingScreenStyle.doneButtonStyle(),),
        onSkip: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LogIn(error: widget.error)));
        },
        next: const Icon(Icons.arrow_forward,size: 35,),
        showSkipButton: true,
        showNextButton: true,
      ) ,
    );
  }

}