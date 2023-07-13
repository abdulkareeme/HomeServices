import 'package:flutter/material.dart';
import 'package:home_services/forget_password/Api/forget_password_api.dart';
import 'package:home_services/forget_password/Screen/set_new_password.dart';


class ForgetPasswordSendCode extends StatelessWidget {
  TextEditingController email;
  String code;
  ForgetPasswordSendCode({Key? key,required this.email,required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordApi ob = ForgetPasswordApi();
    return  FutureBuilder(
      future: ob.sendVerificationCodeForForgetPassword(email, code),
      builder: (context, AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return ResetForgetPassword(
              email: email,
              code: code,
            );
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
