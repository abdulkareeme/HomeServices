import 'package:flutter/material.dart';
import 'package:home_services/forget_password/Widget/reset_forget_password.dart';
import 'package:home_services/my_field.dart';

class ResetForgetPassword extends StatefulWidget {
  TextEditingController email;
  String code;
  ResetForgetPassword({Key? key,required this.code,required this.email}) : super(key: key);

  @override
  State<ResetForgetPassword> createState() => _ResetForgetPasswordState();
}

class _ResetForgetPasswordState extends State<ResetForgetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validForm(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text("الرجاء إدخال كلمة المرور الجديدة",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          errorText: "",
                          enabledBorder: OutlineInputBorder(),
                          hintText: "كلمة المرور",
                          label: Text("كلمة المرور"),
                          focusedBorder: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(),
                      ),
                      controller: newPasswordController,
                      validator: (data){
                        if(newPasswordController.text.isEmpty){
                          return "required";
                        } else {
                          if(confirmNewPasswordController.text.length <8){
                            return "كلمة المرور يجب ان تحو 8 محارف على الاقل";
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        errorText: "",
                        enabledBorder: OutlineInputBorder(),
                        hintText: "تأكيد كلمة المرور",
                        label: Text("تأكيد كلمة المرور"),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(),
                      ),
                      controller: confirmNewPasswordController,
                      validator: (data){
                        if(confirmNewPasswordController.text.isEmpty){
                          return "required";
                        } else {
                          if(confirmNewPasswordController.text != newPasswordController.text){
                            return "كلمة المرور غير متطابقة";
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendNewPasswordForForgetPassword(
                        code: widget.code,
                        email: widget.email,
                        password: newPasswordController,
                        confirmPassword: confirmNewPasswordController,
                      )));
                    },child: const Text("تغيير كلمة المرور"),
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
