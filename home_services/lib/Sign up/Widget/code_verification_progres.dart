import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
// ignore: must_be_immutable
class CodeVerificationProcess extends StatelessWidget{
  String email , code;
  CodeVerificationProcess({
    required this.email,
    required this.code,
    super.key,
  });
  String error = "";
  @override
  Widget build(BuildContext context) {
    SignUpApi ob = SignUpApi();
    return FutureBuilder(
      future: ob.postVerificationCode(code, email),
      builder: (context, AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return LogIn(error: error);
          } else {
            return AlertDialog(
              content: const Text("رمز خاطئ, الرجاء اعادة المحاولة"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          }
        } else {
          return AlertDialog(
            content: const Text("حدث خطأ اثناء الاتصال, الرجاء المحاولة لاحقا"),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        }
      },
    );
  }

}