import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/my_int_field.dart';
import 'package:home_services/style/create_new_service_style.dart';
import 'package:home_services/user_profile/create_new_service/Screen/form_page.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


// ignore: must_be_immutable
class CreateNewService extends StatefulWidget{
  var user;
  List areaList;
  List categoriesList;
  TextEditingController titleController,descriptionController,priceController;
  CreateNewService({
    required this.descriptionController,
    required this.titleController,
    required this.priceController,
    required this.user,
    required this.areaList,
    required this.categoriesList,
    super.key
   });
  @override
  State<StatefulWidget> createState() => _CreateNewServiceState();
}

class _CreateNewServiceState extends State<CreateNewService>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List selectedAreas = [];
  bool categoryError = false;
  bool selectedArea = false;
  String? type = "التصنيف";
  bool formState(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: const Text("إضافة خدمة جديدة"),
          ),
          body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    children:[
                      SizedBox(height: MediaQuery.of(context).size.height/59,),
                      Text("",style: CreateNewServiceStyle.headerStyle(),),
                      SizedBox(height: MediaQuery.of(context).size.height/89,),

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
                          padding: const EdgeInsets.only(left: 30, right: 30,bottom: 10),
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    ))),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            items: widget.categoriesList
                                .map((e) => DropdownMenuItem(
                                value: e[0],
                                child: Text(
                                  "${e[1]}",
                                  style: const TextStyle(
                                    fontSize: 17
                                  ),
                                )))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                type = val.toString();
                              });
                            },
                            hint: const Text(
                              'تصنيف الخدمة',
                              style: TextStyle(color: Colors.black,fontSize: 17),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Visibility(
                          visible: categoryError,
                          child: const Text("required",style: TextStyle(color: Colors.red,fontSize: 16),),
                        ),
                      ),
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
                            items: widget.areaList.map((itme) => MultiSelectItem(itme[0], itme[1])).toList(), onConfirm: (val){
                          setState(() {
                            selectedAreas = val;
                          });
                          //print(sel);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Visibility(
                          visible: selectedArea,
                          child: const Text("required",style: TextStyle(color: Colors.red,fontSize: 16),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                padding:const EdgeInsets.only(top: 5,bottom: 5,left: 30,right: 30),
                                primary: Colors.grey[700]
                              ),
                              onPressed: (){
                                  if(formState() && selectedAreas.isNotEmpty && type != "التصنيف"){
                                    setState(() {
                                      selectedArea = false;
                                      categoryError = false;
                                    });
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceForm(
                                      areaList: selectedAreas,
                                      descriptionController: widget.descriptionController,
                                      priceController: widget.priceController,
                                      titleController: widget.titleController,
                                      serviceType: type,
                                      user: widget.user,
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
                                    if(type == "التصنيف") {
                                      setState(() {
                                        categoryError = true;
                                      });
                                    } else {
                                      setState(() {
                                        categoryError = false;
                                      });
                                    }
                                  }
                              },
                              child: const Text("التالي",style: TextStyle(
                                fontSize: 20,
                              ),)),
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