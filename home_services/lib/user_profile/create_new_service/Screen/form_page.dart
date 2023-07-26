import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/user_profile/create_new_service/Widget/create_new_service.dart';
import 'package:home_services/user_profile/create_new_service/Widget/form_item.dart';

// ignore: must_be_immutable
class ServiceForm extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  var titleController,priceController,descriptionController,serviceType,areaList,user;

  ServiceForm({
    required this.priceController,
    required this.user,
    required this.descriptionController,
    required this.areaList,
    required this.serviceType,
    required this.titleController,
    super.key
  }) ;

  @override
  State<StatefulWidget> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm>{
  TextEditingController problemDescriptionController = TextEditingController(
    text: "وضف المشكلة"
  );
  TextEditingController addressController = TextEditingController(
    text: "العنوان الحالي"
  );
  TextEditingController phoneNumberController = TextEditingController(
    text: "رقم الموبايل"
  );
  TextEditingController expectedCompletionTime = TextEditingController(
    text: "مدة الانتهاء المتوقعة"
  );
  TextEditingController problemDescriptionControllerType= TextEditingController(
    text: "نص"
  );
  TextEditingController addressControllerType = TextEditingController(
      text: "نص"
  );
  TextEditingController phoneNumberControllerType = TextEditingController(
      text: "رقم"
  );
  TextEditingController expectedCompletionTimeType = TextEditingController(
      text: "رقم"
  );
  List forms = [];
  void addItem(){
    FormItem ob = FormItem(formList: forms,index: forms.length,questionController: TextEditingController(text: ""),noteController: TextEditingController(text: ""),responsetype: "نص",);
    setState(() {
      forms.add(ob);
    });
  }
  @override
  Widget build(BuildContext context) {
    List formsData = [
      [
        problemDescriptionController,
        problemDescriptionControllerType
      ],
      [
        addressController,
        addressControllerType
      ],
      [
        phoneNumberController,
        phoneNumberControllerType
      ],
      [
      expectedCompletionTime,
      expectedCompletionTimeType
      ]];
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
         body: SingleChildScrollView(
           child: Form(
             child: Column(
               children: [
                 const SizedBox(height: 50,),
                 const Text("اضف اسئلة للزبون",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                 const SizedBox(height: 7,),
                 const Text("للمساعدة للحصول على المعلومات من الزبون بدقة",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                 const SizedBox(height: 90,),
                 Row(
                   children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width-110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 10.0,
                         contorller: problemDescriptionController,
                         hintText: "وضف المشكلة",
                         obscure: false,
                         lable: const Text("وضف المشكلة"),
                         readOnly: true,
                         color: Colors.white,
                         maxLine: 2,
                         maxLetters: 40,
                         sidesColor: Colors.black38,
                       ),
                     ),
                     SizedBox(
                        width: 110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 0.0,
                         contorller: problemDescriptionControllerType,
                         hintText: "نص",
                         obscure: false,
                         lable:const Text("نص"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     )
                   ],
                 ),
                 Row(
                   children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width-110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 10.0,
                         contorller: addressController,
                         hintText: "العنوان الحالي",
                         obscure: false,
                         lable: const Text("العنوان الحالي"),
                         readOnly: true,
                         maxLine: 2,
                         maxLetters: 30,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     ),
                     SizedBox(
                       width: 110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 0.0,
                         contorller: addressControllerType,
                         hintText: "نص",
                         obscure: false,
                         lable:const Text("نص"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     )
                   ],
                 ),
                 Row(
                   children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width-110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 10.0,
                         contorller: phoneNumberController,
                         hintText: "رقم الموبايل",
                         obscure: false,
                         lable: const Text("رقم الموبايل"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     ),
                     SizedBox(
                       width: 110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 0.0,
                         contorller: phoneNumberControllerType,
                         hintText: "رقم",
                         obscure: false,
                         lable:const Text("رقم"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     )
                   ],
                 ),
                 const SizedBox(height: 20,),
                 Row(
                   children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width-110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 10.0,
                         contorller: expectedCompletionTime,
                         hintText: "مدة الانتهاء المتوقعة",
                         obscure: false,
                         lable: const Text("مدة الانتهاء المتوقعة"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     ),
                     SizedBox(
                       width: 110,
                       child: MyFild(
                         leftPadding: 10.0,
                         rightPadding: 0.0,
                         contorller: expectedCompletionTimeType,
                         hintText: "رقم",
                         obscure: false,
                         lable:const Text("رقم"),
                         readOnly: true,
                         color: Colors.white,
                         sidesColor: Colors.black38,
                       ),
                     )
                   ],
                 ),
                 for(int i=0;i<forms.length;i++)forms[i],
                 Padding(
                   padding: const EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             primary: Colors.green,
                             padding: const EdgeInsets.only(left: 20,right: 20),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                           ),
                           onPressed: (){
                             showDialog(context: context, builder: (context){
                               return AlertDialog(
                                 title: Text("تأكيد انشاء خدمة ${widget.titleController.text} ؟"),
                                 actions: <Widget>[
                                   ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                   ),
                                     onPressed: () {

                                       Navigator.of(context).pop();
                                     },
                                     child: const Text('إلغاء'),
                                   ),
                                   ElevatedButton(
                                     onPressed: () {
                                       for(int i=0;i<forms.length;i++){
                                         if(forms[i].getVisibility() == true){
                                           List op = [];
                                           if(forms[i].getQuestion() != null) {
                                             op.add(forms[i].getQuestion());
                                           } else {
                                             TextEditingController os = TextEditingController(text: "");
                                             op.add(os);
                                           }
                                           op.add(forms[i].getFieldType());
                                           if(forms[i].getNote() != null){
                                             op.add(forms[i].getNote());
                                           } else {
                                             TextEditingController of = TextEditingController(text: "");
                                             op.add(of);
                                           }
                                           //print(op);
                                           formsData.add(op);
                                         }
                                       }
                                       //print(formsData);
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateService(
                                           areaList: widget.areaList,
                                           priceController: widget.priceController,
                                           type: widget.serviceType,
                                           descriptionController: widget.descriptionController,
                                           titleController: widget.titleController,
                                           formList: formsData,
                                           user: widget.user)));
                                     },
                                     child: const Text('إنشاء'),
                                   ),
                                 ],
                               );
                             });

                       }, child: const Text("إنشاء الخدمة",style:TextStyle(fontSize: 17),)),
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             padding: const EdgeInsets.only(left: 20,right: 20),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                           ),
                           onPressed: (){
                         addItem();
                       }, child: const Text("إضافة سؤال للمستخدم",style:TextStyle(fontSize: 17),)),
                     ],
                   ),
                 )
               ],
             ),
           ),
         ),
        ),
      ),
    );
  }


}