import 'package:flutter/material.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
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
                  if(snapshot.connectionState == ConnectionState.done){
                    bool ok = true;
                    for(int i=0;i<snapshot.data!.length;i++){
                      //print(snapshot.data![i]);
                      if(snapshot.data![i] != null){
                        continue;
                      } else {
                        ok = false;
                        break;
                      }
                    }
                    if(ok){
                      //print("heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey");
                      return HomePage(userInfo: snapshot.data);
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