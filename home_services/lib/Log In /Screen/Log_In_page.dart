import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/Log_In_button_and_field.dart';
import '../../Sign up/Widget/get_area_list.dart';
import 'package:home_services/style/log_in_style.dart';

// ignore: must_be_immutable
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
                child: SizedBox(
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

                    const Image(image:AssetImage("images/logo.png"),width: 280,height: 200,),

                    // Log in button and field
                    LogInButtonAndField(
                      height: height,
                      loginError: widget.error,
                    )/*)*/,

                    const SizedBox(height: 6,),

                    // don't have account option

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "لا تملك حساب حاليا ؟ ",
                            style: LogInStyle.alreadyHaveAccountStyle(),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const GetAreaList()));
                            },
                            focusColor: Colors.black,
                            child: Text(
                              "إنشاء حساب",
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
