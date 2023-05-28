import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';


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
  LogInApis op = LogInApis() ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (
            Center(
              child: FutureBuilder<List?>(
                future:op.login(widget.usernameController, widget.passwordController, widget.error),
                builder: (context,AsyncSnapshot<List?> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data!.length == 0){
                      return LogIn(error: widget.error  ,);
                    } else {
                      return (
                          Column(
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
                          )
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