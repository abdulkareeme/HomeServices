import 'package:flutter/material.dart';
import 'package:home_services/update user info/Api/update_user_info_Api.dart';

class UserOldInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _UserOldInfoState();
}

class _UserOldInfoState extends State<UserOldInfo>{
  UpdateUserInfoApis op = UpdateUserInfoApis();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: FutureBuilder(
              future: op.getUserOldData(),
              builder: (context, AsyncSnapshot<List?> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    return Container();
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