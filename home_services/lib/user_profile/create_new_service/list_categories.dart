import 'package:flutter/material.dart';
import 'package:home_services/Sign%20up/Api/sign_up_api.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/create_new_service_page.dart';
import 'package:home_services/user_profile/create_new_service/list_area.dart';



class GetCategoriesList extends StatelessWidget{
  const GetCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileApi ob =ProfileApi();
    return (
      Scaffold(
        body: FutureBuilder(
            future:ob.getCategories(),
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
                  return GetListArea(categoriesList: snapshot.data!);
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