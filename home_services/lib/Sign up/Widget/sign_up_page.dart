import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_page.dart';
import 'package:home_services/Sign%20up/Widget/code_verification_page.dart';
import 'package:home_services/server/api_url.dart';
import 'package:http/http.dart';

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
    Future<List?> signUp() async {
      //String url = "http://abdulkareemedres.pythonanywhere.com/api/register/";
      Response response = await post(Uri.parse(Server.host+Server.signupApi), body: {
        'username': widget.username,
        'password': widget.passwordController.text,
        'password2': widget.confirmaPasswordController.text,
        'email': widget.emailController.text,
        'first_name': widget.firstnameController.text,
        'last_name': widget.lastnameController.text,
        'birth_date': widget.birthdatecontroller.text,
        'gender': widget.gender,
        'mode': widget.mode,
        'area': '1',
      });
      var op =["done"];
      if (response.statusCode == 200|| response.statusCode==201) {
        print (jsonDecode(response.body));
        return op;
      } else {
        var os = [];
        String ok = "";
        var info = jsonDecode(response.body);
        bool oq = false;
        if(info['email'] != null && info['password'] != null) oq = true;
        if(info['email'] != null)ok+='email  : '+info['email'][0];
        if(oq)ok+='\n'+'\n' ;
        if(info['password'] != null)ok+='password  : '+info['password'][0];
        os.add(ok);
        return os;
      }
    }

    return SafeArea(
      child: Scaffold(
          body:Center(
            child: FutureBuilder(
              future: signUp(),
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
