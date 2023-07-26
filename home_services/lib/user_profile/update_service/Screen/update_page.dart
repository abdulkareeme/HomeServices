import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/service.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/my_int_field.dart';
import 'package:home_services/user_profile/create_new_service/Widget/form_item.dart';
import 'package:home_services/user_profile/update_service/Widget/send_data.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

// ignore: must_be_immutable
class UpdateService extends StatefulWidget {
   // ignore: prefer_typing_uninitialized_variables
  var user,formList;
  List areaList;
  ServiceDetails service;
  TextEditingController titleController,descriptionController,priceController;
  UpdateService({
    required this.descriptionController,
    required this.titleController,
    required this.priceController,
    required this.user,
    required this.areaList,
    required this.service,
    required this.formList,
    super.key
  });

  @override
  State<UpdateService> createState() => _UpdateServiceState();
}

class _UpdateServiceState extends State<UpdateService> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List selectedAreas = ['asdf','asdf'];
  List forms = [];
  List formData = [];
  bool selectedArea = false;
  bool formState(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  void initState() {
    for(int i=4;i<widget.formList.length;i++){
      FormItem ob =FormItem(questionController: TextEditingController(text: widget.formList[i][0]), noteController: TextEditingController(text:widget.formList[i][2]),responsetype: widget.formList[i][1],);
      forms.add(ob);
    }
    for(int i=0;i<4;i++){
      List os = [];
      os.add(widget.formList[i][0]);
      os.add(widget.formList[i][1]);
      formData.add(os);
    }
    super.initState();
  }
  void add(){
    FormItem ob = FormItem(
      questionController: TextEditingController(text: ""),
      noteController: TextEditingController(text: ""),
      responsetype: "نص"
    );
    setState(() {
      forms.add(ob);
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: Text("تعديل ${widget.service.title} "),
          ),
          body:SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children:  [
                    SizedBox(height: height/11,),

                    // Title field
                    MyFild(
                      leftPadding: 20.0,
                      rightPadding: 20.0,
                      errorText: "",
                      contorller: widget.titleController,
                      hintText: "عنوان الخدمة",
                      obscure: false,
                      lable: const Text("عنوان الخدمة"),
                      readOnly: false,
                      color: Colors.white,
                      sidesColor: Colors.black38,
                      val: (_){
                        if(widget.titleController.text.isEmpty){
                          return "required";
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 20,),
                    MyFild(
                      leftPadding: 20.0,
                      rightPadding: 20.0,
                      errorText: "",
                      contorller: widget.descriptionController,
                      hintText: "تعريف بالخدمة",
                      obscure: false,
                      lable: const Text("تعريف بالخدمة"),
                      readOnly: false,
                      color: Colors.white,
                      sidesColor: Colors.black38,
                      val: (_){
                        if(widget.descriptionController.text.isEmpty){
                          return "required";
                        } else {
                          return null;
                        }
                      },
                      maxLine: 5,
                      maxLetters: 100,
                    ),
                    const SizedBox(height: 20,),
                    MyINTField(
                      contorller: widget.priceController,
                      hintText: "أجر الساعة الواحدة",
                      obscure: false ,
                      lable: const Text("أجر الساعة الواحدة"),
                      readOnly: false,
                      color: Colors.white,
                      val:(_){
                        if(widget.priceController.text.isEmpty){
                          return "required";
                        } else {
                          return null;
                        }
                      },
                      sidesColor: Colors.black38,
                      keyboardType: TextInputType.number,
                    )
                    ,
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: MultiSelectDialogField(
                          title: const Text("المدن"),
                          buttonText: const Text("إختيار المدن",style: TextStyle(fontSize: 17),),
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black38))

                          ),
                          buttonIcon: const Icon(Icons.arrow_drop_down),
                          searchIcon: const Icon(Icons.search),
                          items: widget.areaList.map((itme) => MultiSelectItem(
                              itme[0], itme[1],)).toList(),
                          onConfirm: (val){
                              setState(() {
                                selectedAreas = val;
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Visibility(
                        visible: selectedArea,
                        child: const Text("required",style: TextStyle(color: Colors.red,fontSize: 16),),
                      ),
                    ),

                    for(int i=0;i<forms.length;i++)forms[i],
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                              ),
                              onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title:  Text("تعديل الخدمة ${widget.service.title} ؟"),
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
                                          if(formState() && selectedAreas.isNotEmpty){
                                            setState(() {
                                              selectedArea = false;
                                            });
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
                                                formData.add(op);
                                              }
                                            }
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendUpdatedService(
                                              descriptionController:widget.descriptionController,
                                              titleController: widget.titleController,
                                              priceController: widget.priceController,
                                              user: widget.user,
                                              service: widget.service,
                                              formData: formData,
                                              selectedArea: selectedAreas,
                                            )));
                                          } else {

                                            if(selectedAreas.isEmpty){
                                              setState(() {
                                                selectedArea = true;
                                              });
                                            } else {
                                              setState(() {
                                                selectedArea = false;
                                              });
                                            }
                                          }
                                        },
                                        child: const Text('تعديل'),
                                      ),
                                    ],
                                  );
                                });
                              },
                              child: const Text("تعديل الخدمة",style:TextStyle(fontSize: 17),)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                              ),
                              onPressed: (){
                                add();
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
