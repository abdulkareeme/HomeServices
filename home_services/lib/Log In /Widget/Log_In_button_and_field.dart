import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';
import '../../style/log_in_style.dart';

// ignore: must_be_immutable
class LogInButtonAndField extends StatefulWidget {
  double height;

  LogInButtonAndField({
    required this.height,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LogInButtonAndFieldState();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";
}

class _LogInButtonAndFieldState extends State<LogInButtonAndField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(widget.error.toString(), style: LogInStyle.errorStyle(),),
        const SizedBox(height: 4,),
        // username field
        MyFild(
          contorller: widget.usernameController,
          hintText: "username",
          obscure: false,
          lable: const Text("username"),
          color: Colors.white,
          sidesColor: Colors.black,
        ),

        const SizedBox(
          height: 15,
        ),

        // password field
        MyFild(
          contorller: widget.passwordController,
          hintText: "password",
          obscure: true,
          lable: const Text("password"),
          color: Colors.white,
          sidesColor: Colors.black,
        ),
        Center(
          child: FutureBuilder(
              future: LogInApi.logIn(
                  widget.usernameController, widget.passwordController),
              builder: (context, AsyncSnapshot<List?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  // ignore: unrelated_type_equality_checks
                  if (snapshot.connectionState == 200) {
                    LogInApi.setSharedPreferences(
                        snapshot.data![0]['user_info']['username'],
                        snapshot.data![0]['user_info']['email'],
                        snapshot.data![0]['token'][0],
                        snapshot.data![0]['user_info']['first_name'],
                        snapshot.data![0]['user_info']['last_name']);
                    print(snapshot.data![0]['user_info']['username']);
                    print(snapshot.data![0]['user_info']['first_name']);
                    print(snapshot.data![0]['user_info']['last_name']);
                  } else {
                    setState(() {
                      widget.error = "invalid username or password";
                    });
                  }
                  return Container();
                } else {
                  return Container();
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Colors.black,
                onTap: () {

                },
                child: Text(
                  "Forget password",
                  style: LogInStyle.forgetPasswordStyle(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {
            LogInApi.logIn(
                widget.usernameController, widget.passwordController);
          },
          style: LogInStyle.buttonStyle(),
          child: Text(
            "Log in",
            style: LogInStyle.logInButtonTextStyle(),
          ),
        ),
      ])),
    );
  }
}
