import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';

import '../../Home Page/home_page.dart';


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
              child:FutureBuilder<List?>(
                future:op1.login(widget.usernameController, widget.passwordController, widget.error),
                builder: (context,AsyncSnapshot<List?> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                    return const CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    print('vbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
                    if(snapshot.hasData &&snapshot.data!.length == 0){
                      print('ccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
                      return LogIn(error: widget.error,);
                    } else {
                      print('ffffffffffffffffffffffffffffffffffffffffffffffffffffff');
                      for(int i=0;i<snapshot.data!.length;i++){
                        print(snapshot.data![i]+'hii there');
                      }
                      return (
                          HomePage(userInfo: snapshot.data!,)
                          /*Column(
                            children: [
                              const Text("log in suc"),
                              const SizedBox(height: 50,),
                              Text(snapshot.data![0].toString()),
                              Text(snapshot.data![1].toString()),
                              Text(snapshot.data![2].toString()),
                              Text(snapshot.data![3].toString()),
                              Text(snapshot.data![4].toString()),
                              Text(snapshot.data![5].toString()),
                            ],
                          )*/
                      );
                    }
                  } else {
                    return (Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"));
                  }
                },
              ),
            )
        ),
      ),
    );
  }


}