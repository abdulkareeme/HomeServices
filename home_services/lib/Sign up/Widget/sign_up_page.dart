// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/Sign up/Api/sign_up_api.dart';
import 'package:home_services/Sign%20up/Screen/code_verification_page.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  var firstnameController,
      lastnameController,
      area,
      birthdatecontroller,
      gender,
      mode,
      emailController,
      passwordController,
      confirmaPasswordController,
      username;
  var emailError, passwordError, confirmPasswordError;

  SignUpPage({
    required this.firstnameController,
    required this.lastnameController,
    required this.area,
    required this.gender,
    required this.mode,
    required this.username,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordError,
    required this.passwordError,
    required this.emailError,
    required this.birthdatecontroller,
    required this.confirmaPasswordController,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
  String errorCase = "";
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    List data = [widget.username,widget.passwordController,widget.confirmaPasswordController,widget.emailController,widget.firstnameController,widget.lastnameController,widget.birthdatecontroller,widget.gender,widget.mode,widget.area];
    SignUpApi op = SignUpApi();
    return SafeArea(
      child: Scaffold(
          body:Center(
            child: FutureBuilder(
              future: op.signUp(data),
              builder: (context , AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else {
                  if(snapshot.connectionState == ConnectionState.done&&snapshot.hasData){
                    if(snapshot.data![0] == "done"){
                      return CodeVerificationPage(email: widget.emailController.text,);
                    } else{
                      return AlertDialog(
                        title: const Text('Failed to sign up'),
                        content: Text(snapshot.data![0]),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('CANCEL'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Perform some action
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  } else{
                    return  AlertDialog(
                      title: const Text('unable to sign up now'),
                      content: const Text('please try again later'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Perform some action
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn(error: widget.errorCase,)));
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
      ),
    );
  }
}
