import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SendEmailForForgetPassword extends StatefulWidget {
  const SendEmailForForgetPassword({Key? key}) : super(key: key);

  @override
  State<SendEmailForForgetPassword> createState() => _SendEmailForForgetPasswordState();
}

class _SendEmailForForgetPasswordState extends State<SendEmailForForgetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      controller: emailController,
                      validator: (data){
                        if(emailController.text.isEmpty){
                          return "required";
                        } else {
                          if(EmailValidator.validate(emailController.text) == false){
                            return "invalid email";
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 5),
                      ),
                      onPressed: (){

                      },
                      child: const Text("إرسال"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
