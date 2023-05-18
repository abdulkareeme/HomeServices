import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../style/on_boarding_screen_style.dart';

class OnBoardingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _OnBoardingScreenState();

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
              Navigator.of(context).pushReplacementNamed("log in");
          },
          skip: Text("Skip",style: OnBoardingScreenStyle.doneButtonStyle(),),
          onSkip: (){
              Navigator.of(context).pushReplacementNamed("log in");
          },
          next: const Icon(Icons.arrow_forward,size: 35,),
          showSkipButton: true,
          showNextButton: true,
        ) ,
    );
  }

}