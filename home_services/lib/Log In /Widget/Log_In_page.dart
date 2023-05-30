import 'package:flutter/material.dart';
import '../../Sign up/Widget/first_page_of_signup.dart';
import 'Log_In_button_and_field.dart';
import 'package:home_services/style/log_in_style.dart';

class LogIn extends StatefulWidget {
  String error;

  LogIn({
    required this.error,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  List op = ['Lattakia', 'Damascus', 'aleppo', 'Hama', 'tartous', 'raqa', 'hasaka', 'Homes'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Scaffold(
          body: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                child: Container(
                  width: width,
                  height: height,
                  child: const Image(
                    image: AssetImage('images/home1.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40,),
                    Text(
                      "منزلي",
                      style: LogInStyle.manzliStyle(),
                    ),

                    const SizedBox(height: 160,),
                    // Log in button and field
                    /*Expanded(
                        child:*/
                    //Text(widget.error,style: LogInStyle.errorStyle(),),
                    LogInButtonAndField(
                      height: height,
                      loginError: widget.error,
                    )/*)*/,
                    const SizedBox(height: 6,),
                    // already have account option
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already have account ? ",
                            style: LogInStyle.alreadyHaveAccountStyle(),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FirstPageOfSignUp(
                                        areaList: op,
                                      )));
                            },
                            focusColor: Colors.black,
                            child: Text(
                              "Sign up",
                              style: LogInStyle.signUpStyle(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
