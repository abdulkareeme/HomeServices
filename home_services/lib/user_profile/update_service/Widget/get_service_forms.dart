import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/update_service/Screen/update_page.dart';


// ignore: must_be_immutable
class GetServiceForm extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user,areaList;
  ServiceDetails service;
  GetServiceForm({
    required this.service,
    this.areaList,
    required this.user,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return FutureBuilder(
      future: ob.getServiceFroms(service.id,user),
      builder: (context,AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data!.isNotEmpty){
            print(snapshot.data);
            return UpdateService(formList: snapshot.data!,areaList: areaList,user: user, service: service, priceController: TextEditingController(
                text: service.hourPrice.toString()
            ),
              titleController: TextEditingController(
                  text: service.title
              ),
              descriptionController: TextEditingController(
                  text: service.description
              ),
            );
          } else {
            return  AlertDialog(
              title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("تأكيد"))
              ],
            );
          }
        } else {
          return AlertDialog(
            title: const Text("حدثت مشكلة اثناء الاتصال, الرجاء المحاولة لاحقا"),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("تأكيد"))
            ],
          );
        }
      },
    );
  }
}
