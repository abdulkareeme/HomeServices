import 'package:flutter/material.dart';
import 'package:home_services/Log In /Api/log_in_api.dart';
import 'package:home_services/Log%20In%20/Screen/Log_In_page.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';
// ignore: must_be_immutable
class LogInApi extends StatefulWidget {
  var usernameController, passwordController;

  LogInApi({
    required this.passwordController,
    required this.usernameController,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _LogInApiState();
}

class _LogInApiState extends State<LogInApi> {
  LogInApis op1 = LogInApis() ;
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        body: (
            Center(
              child:FutureBuilder(
                future:op1.login(widget.usernameController, widget.passwordController,),
                builder: (context,AsyncSnapshot<List?> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    if(snapshot.data!.isEmpty){
                      return AlertDialog(
                        title: const Text("يوجد خطأ في البريد الالكتروني او كلمة السر, يرجى اعادة المحاولة"),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn(error: "")));
                            },
                            child: const Text("تأكيد"))
                        ],
                      );
                    } else {
                      return (
                          GetCategoriesList(op: true,user: snapshot.data![0],)
                      );
                    }
                  } else {
                    return AlertDialog(
                      title: const Text("حدث خطأ أثناء الاتصال, يرجى اعادة المحاولة"),
                      actions: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn(error: "")));
                            },
                            child: const Text("تأكيد"))
                      ],
                    );
                  }
                },
              ),
            )
        ),
      ),
    );
  }


}