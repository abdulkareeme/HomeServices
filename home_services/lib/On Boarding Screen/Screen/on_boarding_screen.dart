import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';
import 'package:introduction_screen/introduction_screen.dart';
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
            title: " ابحث عن الخدمات المنزلية بكل سهولة وسرعة ",
            //body: "our feature are the best",
            bodyWidget: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Image(image: AssetImage("images/11.png"),),
            )
          ),
          PageViewModel(
            title: "اختر مزود الخدمة صاحب التقييم الاعلى والافضل",
            bodyWidget: Padding(
              padding: const EdgeInsets.only(top:60),
              child: Image(image:AssetImage("images/22.png")),
            )
          ),
          PageViewModel(
              title: " امكانية تقييم بائع الخدمة من عدة نواحي اساسية ",
              //body: "our feature are the best",
              bodyWidget: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Image(image: AssetImage("images/33.png"),),
              )
          ),
          PageViewModel(
              title: " ابدأ التجربة الان  ",
              //body: "our feature are the best",
              bodyWidget: Padding(
                padding: const EdgeInsets.only(top: 220),
                child: Image(image: AssetImage("images/logo-black.png"),),
              )
          ),
        ],
        done: Text("ابدأ",style: OnBoardingScreenStyle.doneButtonStyle(),),
        onDone: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn(error: widget.error)));
        },
        skip: Text("تخطي",style: OnBoardingScreenStyle.doneButtonStyle(),),
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