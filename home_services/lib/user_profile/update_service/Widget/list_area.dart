import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
import 'package:home_services/user_profile/update_service/Widget/get_service_forms.dart';

// ignore: must_be_immutable
class GetListArea extends StatelessWidget{
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ServiceDetails service;
  GetListArea({required this.user,required this.service,super.key});

  @override
  Widget build(BuildContext context) {
    SignUpApi ob =SignUpApi();
    return (
        Scaffold(
          body: FutureBuilder(
            future:ob.getAreaList(),
            builder: (context,AsyncSnapshot<List?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                if(snapshot.data!.isEmpty){
                  return AlertDialog(
                    title: const Text("ERROR"),
                    content: const Text('Unable To Create Service Now'),
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
                  return GetServiceForm(service: service, areaList: snapshot.data!, user: user,);
                }
              } else {
                return AlertDialog(
                  title: const Text("ERROR"),
                  content: const Text('Unable To Create Service Now'),
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
        )
    );
  }

}