import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:home_services/forget_password/Widget/send_email.dart';

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
                  const Text("الرجاء إدخال الايميل لكي يتم ارسال رمز تحقق",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        errorText: "",
                        enabledBorder: OutlineInputBorder(),
                        hintText: "أدخل الايميل",
                        label: Text("الايميل"),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(),
                      ),
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendEmail(emailController:emailController,)));
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
