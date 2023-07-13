import 'package:flutter/material.dart';
import 'package:home_services/Log%20In%20/Widget/check_if_user_logged_in.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
// ignore: must_be_immutable
class SetUserNewData extends StatefulWidget{
  var userNewData;
  SetUserNewData({
    required this.userNewData,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _SetUserNewDataState();
}

class _SetUserNewDataState extends State<SetUserNewData>{
  ProfileApi op = ProfileApi();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: FutureBuilder(
              future: op.setUserNewData(widget.userNewData),
              builder: (context, AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    return CheckIfLoggedIn();
                  } else {
                    return AlertDialog(
                      title: const Text('unable to update data'),
                      content: const Text('please try again later'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Perform some action
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        )
    );
  }


}