import 'package:flutter/material.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';
import '../../Home Page/home_page.dart';
import '../../On Boarding Screen/Widget/on_boarding_screen.dart';

// ignore: must_be_immutable
class CheckIfLoggedIn extends StatefulWidget{
  CheckIfLoggedIn({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CheckIfLoggedInState();
  String initialLogInError = "";
}

class _CheckIfLoggedInState extends State<CheckIfLoggedIn>{
  LogInApis op = LogInApis();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: FutureBuilder(
              future: op.checkIfLoggedIn(),
              builder: (context,AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else{
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){

                    if(snapshot.data!.isNotEmpty){
                      // we need to defined a user or seller object
                      // then return it to the home page
                      return HomePage(user: snapshot.data![0]);
                    } else {
                        return OnBoardingScreen();
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                }
              },
            ),
          ),
        )
    );
  }

}