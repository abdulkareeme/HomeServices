import 'package:flutter/material.dart';
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
}


class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Future signUp() async {
      String url = "http://abdulkareemedres.pythonanywhere.com/api/register/";
      Response response = await post(Uri.parse(url), body: {
        "username": widget.username,
        "password": widget.passwordController.text,
        "password2": widget.confirmaPasswordController.text,
        "email": widget.emailController.text,
        "first_name": widget.firstnameController.text,
        "last_name": widget.lastnameController.text,
        "birth_date": widget.birthdatecontroller.text,
        "gender": widget.gender,
        "photo": "",
        "mode": widget.mode,
        "area": widget.area,
      });
      String? op ="okkkkkkkkkkkkkkkkkkkkkkkkkkkk";
      if (response.statusCode == 200) {
        return op;
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    return Center(
      child: Scaffold(
        appBar: AppBar(),
        body:FutureBuilder(
          future: signUp(),
          builder: (context , AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            } else {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return Column(children: [Text(snapshot.data)],);
                } else{
                  return Column(children:const [Text("no data")],);
                }
              } else{
                return const Text("error");
              }
            }
          },
        ),
      ),
    );
  }
}
