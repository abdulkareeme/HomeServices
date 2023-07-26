import 'package:flutter/material.dart';
import 'package:home_services/Main Classes/form.dart';
import 'package:home_services/user_profile/Sent%20Orders/Widget/singel_form_item.dart';
// ignore: must_be_immutable
class FormReviewPage extends StatelessWidget {
  List<Form1> forms;
  FormReviewPage({Key? key ,required this.forms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: const Text("فورم الخدمة"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                for(int i=0;i<forms.length;i++) Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleFormItem(title: forms[i].field.title, controller: TextEditingController(text: forms[i].content)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
