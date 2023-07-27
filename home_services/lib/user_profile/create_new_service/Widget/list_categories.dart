import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Widget/get_all_services.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_area.dart';



// ignore: must_be_immutable
class GetCategoriesList extends StatelessWidget{
  var user;
  bool op ;
  GetCategoriesList({required this.user,required this.op,super.key}) ;

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
                  return (op == false)?GetListArea(categoriesList: snapshot.data!,user: user,): GetAllServices(user: user,categoryList: snapshot.data!,);
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