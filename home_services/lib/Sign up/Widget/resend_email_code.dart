import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Screen/code_verification_page.dart';
import '../Api/sign_up_api.dart';

class ResendEmailCode extends StatelessWidget{
  String email;
  ResendEmailCode({
    required this.email,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    SignUpApi ob = SignUpApi();
    return FutureBuilder(
      future: ob.resendEmailCode(email),
      builder: (context , AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          if(snapshot.data!.isEmpty){
            return CodeVerificationPage(email: email,);
          } else {
            return AlertDialog(
              content: const Text("حدث خطأ اثناء الاتصال, الرجاء المحاولة لاحقا"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
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
                child: const Text('CANCEL'),
              ),
            ],
          );
        }
      },
    );
  }


}