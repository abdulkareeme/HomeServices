import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/forget_password/Api/forget_password_api.dart';


class SendNewPasswordForForgetPassword extends StatelessWidget {
  TextEditingController password,confirmPassword,email;
  String code;
  SendNewPasswordForForgetPassword({Key? key,required this.confirmPassword,required this.password,required this.email,required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordApi ob = ForgetPasswordApi();
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: ob.resetForgetPassword(email, code, password, confirmPassword),
            builder:(context,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              } else if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isEmpty){
                  return AlertDialog(
                    title: const Text("تم تغيير كلمة المرور بنجاح"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn(error: "")));
                      }, child: const Text("تأكيد"))
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text("تأكيد"))
                    ],
                  );
                }
              } else {
                return AlertDialog(
                  title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: const Text("تأكيد"))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
