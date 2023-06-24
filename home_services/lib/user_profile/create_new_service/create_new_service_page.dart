import 'package:flutter/material.dart';

import '../../my_field.dart';
import '../../style/create_new_service_style.dart';

// ignore: must_be_immutable
class CreateNewService extends StatefulWidget{
   CreateNewService({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CreateNewServiceState();
  TextEditingController titleController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();
}

class _CreateNewServiceState extends State<CreateNewService>{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Column(
                children:  [
                  SizedBox(height: height/9,),
                  Text("إنشاء خدمة جديدة",style: CreateNewServiceStyle.headerStyle(),),
                  SizedBox(height: height/11,),
                  
                  // Title field
                  MyFild(
                    contorller: widget.titleController,
                    hintText: "عنوان الخدمة",
                    obscure: false,
                    lable: const Text("عنوان الخدمة"),
                    readOnly: false,
                    color: Colors.white,
                    sidesColor: Colors.black,
                  ),
                  const SizedBox(height: 20,),
                  MyFild(
                    contorller: widget.descriptionController,
                    hintText: "تعريف بالخدمة",
                    obscure: false,
                    lable: const Text("تعريف بالخدمة"),
                    readOnly: false,
                    color: Colors.white,
                    sidesColor: Colors.black,
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
  
  
}