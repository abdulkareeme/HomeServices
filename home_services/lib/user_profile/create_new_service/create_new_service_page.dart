import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../my_field.dart';
import '../../my_int_field.dart';
import '../../style/create_new_service_style.dart';
import 'form_page.dart';

// ignore: must_be_immutable
class CreateNewService extends StatefulWidget{
  List areaList;
  List categoriesList;
   CreateNewService({
     required this.areaList,
     required this.categoriesList,
     super.key
   });
  @override
  State<StatefulWidget> createState() => _CreateNewServiceState();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
}

class _CreateNewServiceState extends State<CreateNewService>{
  List sel = [];
  String? area = "التصنيف";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
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
                      sidesColor: Colors.black,
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
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
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
                            print(val);
                            setState(() {
                              area = val.toString();
                            });
                          },
                          hint: const Text(
                            'تصنيف الخدمة',
                            style: TextStyle(color: Colors.black,fontSize: 17),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: MultiSelectDialogField(
                        title: const Text("المدن"),
                        buttonText: const Text("إختيار المدن",style: TextStyle(fontSize: 17),),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black))

                        ),
                        buttonIcon: const Icon(Icons.arrow_drop_down),
                          searchIcon: const Icon(Icons.search),
                          items: widget.areaList.map((itme) => MultiSelectItem(itme[0], itme[1])).toList(), onConfirm: (val){
                        setState(() {
                          sel = val;
                        });
                        print(sel);
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              padding:const EdgeInsets.only(top: 5,bottom: 5,left: 30,right: 30)
                            ),
                            onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceForm()));
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