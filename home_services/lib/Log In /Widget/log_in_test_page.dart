import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_button_and_field.dart';
import 'package:http/http.dart';

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
  @override
  Widget build(BuildContext context) {
    Future<List?> login() async {
      String url = "http://abdulkareemedres.pythonanywhere.com/api/login/";
      Response response = await post(Uri.parse(url), body: {
        'username': widget.usernameController.text,
        'password': widget.passwordController.text,
      });
      List info = [];
      if (response.statusCode == 200) {
        var op = jsonDecode(response.body);
        info.clear();
        info.add(op['user_info']['username']);
        info.add(op['user_info']['first_name']);
        info.add(op['user_info']['last_name']);
        info.add(op['user_info']['email']);
        info.add(op['user_info']['mode']);
        info.add(op['token'][0]);

      } else {
          widget.error = "invalid username or password";
      }
      return info;
    }

    return SafeArea(
      child: Scaffold(
        body: (
            Center(
              child: FutureBuilder<List?>(
                future: login(),
                builder: (context,AsyncSnapshot<List?> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data!.length == 0){
                      return LogIn(error: widget.error,);

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