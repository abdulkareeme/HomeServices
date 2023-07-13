import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/user_profile/Api/User_Profile_Api.dart';
import 'package:home_services/user_profile/create_new_service/Widget/list_categories.dart';

// ignore: must_be_immutable
class SendUpdatedService extends StatelessWidget {
  TextEditingController titleController,descriptionController,priceController;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ServiceDetails service;
  List formData,selectedArea;
  SendUpdatedService({
    required this.priceController,
    required this.descriptionController,
    required this.titleController,
    required this.user,
    required this.service,
    required this.formData,
    required this.selectedArea,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileApi ob = ProfileApi();
    return FutureBuilder(
      future: ob.updateService(titleController, descriptionController, priceController, selectedArea, formData, user, service.id),
      builder: (context,AsyncSnapshot<List?> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data!.isEmpty){
            return  AlertDialog(
              title: Text("تم تعديل خدمة ${service.title} بنجاح "),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GetCategoriesList(user: user, op: true)));
                }, child: const Text("تأكيد"))
              ],
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
          return  AlertDialog(
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
