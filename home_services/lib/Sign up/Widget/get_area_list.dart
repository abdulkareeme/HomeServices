import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
import 'package:home_services/Sign%20up/Widget/first_page_of_signup.dart';

class GetAreaList extends StatelessWidget{
  const GetAreaList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SignUpApi ob = SignUpApi();
    return(
      Center(
        child: Scaffold(
          body: FutureBuilder(
            future: ob.getAreaList(),
            builder: (context,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                if(snapshot.data!.isEmpty){
                  return AlertDialog(
                    title: const Text("ERROR"),
                    content: const Text('Unable To Sign Up Right Now'),
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
                } else {
                  return FirstPageOfSignUp(areaList: snapshot.data!);
                }
              } else {
                return AlertDialog(
                  title: const Text("ERROR"),
                  content: const Text('Unable To Sign Up Right Now'),
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
            },
          ),
        ),
      )
    );
  }



}