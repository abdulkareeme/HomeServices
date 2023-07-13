import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
import 'package:home_services/user_profile/create_new_service/Screen/create_new_service_page.dart';



// ignore: must_be_immutable
class GetListArea extends StatelessWidget{
  var categoriesList;
  var user;
  GetListArea({required this.categoriesList,required this.user,super.key});

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
                  return CreateNewService(categoriesList:categoriesList,areaList: snapshot.data!,user: user,titleController: TextEditingController(),descriptionController: TextEditingController(),priceController: TextEditingController(),);
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