import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_services/Sign up/Api/sign_up_api.dart';
import 'package:home_services/style/code_verification_page.dart';

class CodeVerificationPage extends StatefulWidget {
   String email;
   CodeVerificationPage({
     required this.email,
     super.key,
  });
  @override
  State<StatefulWidget> createState() => _CodeVerificationPageState();
  TextEditingController firstDigit = TextEditingController();
  TextEditingController secondDigit = TextEditingController();
  TextEditingController thirdDigit = TextEditingController();
  TextEditingController fourthDigit = TextEditingController();
  TextEditingController fifthDigit = TextEditingController();
  TextEditingController sixthDigit = TextEditingController();
  String code = "";
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        appBar:AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("أدخر رمز التحقق",style: CodeVerificationPageStyle.mainText(),),
                const SizedBox(height: 8,),
                // ignore: prefer_interpolation_to_compose_strings
                Text("تم ارسال رمز تحقق على البريد",style: CodeVerificationPageStyle.secondaryText(),),
                Text(widget.email,style: const TextStyle(fontSize: 16),),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            focusNode: _focusNode,
                            autofocus: true,
                            controller: widget.firstDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            controller: widget.secondDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            controller: widget.thirdDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            controller: widget.fourthDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            controller: widget.fifthDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 45,
                          child: TextFormField(
                            controller: widget.sixthDigit,
                            onChanged: (val) {
                              if (val.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height:35,),
                ElevatedButton(
                  onPressed: (){
                    widget.code = widget.firstDigit.text.toString()+widget.secondDigit.text.toString()+widget.thirdDigit.text.toString()+widget.fourthDigit.text.toString()+widget.fifthDigit.text.toString()+widget.sixthDigit.text.toString();
                    SignUpApi op = SignUpApi();
                    op.postVerificationCode(widget.code, widget.email, context);

                  },
                  style: CodeVerificationPageStyle.buttonStyle(),
                  child: Text("إرسال",style:CodeVerificationPageStyle.buttonText() ,),
                ),
                const SizedBox(height: 35,),
                Padding(
                  padding: const EdgeInsets.only(right: 30,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Text("إعادة ارسال الرمز",style: CodeVerificationPageStyle.resendCondeText(),),
                      ),
                      Text('لم يصلك رمز التحقق ؟ ',style: CodeVerificationPageStyle.checkForResendText(),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
