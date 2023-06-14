import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';

import '../../Home Page/home_page.dart';


// ignore: must_be_immutable
class LogInApi extends StatefulWidget {
  var usernameController, passwordController;

  LogInApi({
    required this.passwordController,
    required this.usernameController,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _LogInApiState();
  String error = "";

}

class _LogInApiState extends State<LogInApi> {
  LogInApis op1 = LogInApis() ;
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        body: (
            Center(
              child:FutureBuilder(
                future:op1.login(widget.usernameController, widget.passwordController, widget.error),
                builder: (context,AsyncSnapshot<List?> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasData &&snapshot.data!.length == 0){
                      return LogIn(error: widget.error,);
                    } else {
                      return (
                          HomePage(userInfo: snapshot.data!,)
                      );
                    }
                  } else {
                    return (const Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"));
                  }
                },
              ),
            )
        ),
      ),
    );
  }


}