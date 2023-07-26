import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

// ignore: must_be_immutable
class FormItem extends StatefulWidget{
  var formList,index,questionController,noteController,responsetype;
  FormItem({
    required this.questionController,
    required this.noteController,
    required this.responsetype,
    this.index,
    this.formList,
    super.key
});
  @override
  State<StatefulWidget> createState() => _FormItemState();
  String fieldType = "text";
  bool vis = true;
   TextEditingController getQuestion() {
      return questionController;
  }
  TextEditingController getNote() {
    return noteController;
  }
  String getFieldType(){
     return fieldType;
  }
  bool getVisibility (){
     return vis;
  }
}
class _FormItemState extends State<FormItem>{
  List fieldsType = [['نص',"text"],['رقم','number']];
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.vis,
      child: (
        Container(
          margin: const EdgeInsets.all(10),
          //padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text("تأكيد الحذف ؟"),
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
                              setState(() {
                                widget.vis = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('حذف'),
                          ),
                        ],
                      );
                    });
                  }, icon: const Icon(Icons.delete,color: Colors.red,))
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-110,
                    child: MyFild(
                      leftPadding: 20.0,
                      rightPadding: 20.0,
                      contorller: widget.questionController,
                      hintText:"",
                      obscure: false,
                      lable: const Text("أدخل السؤال"),
                      readOnly: false,
                      color: Colors.white,
                      sidesColor: Colors.black38,
                      maxLine: 5,
                      maxLetters: 50,
                    ),
                  ),
                  DropdownButton(
                      hint: Text(widget.responsetype),
                        items:fieldsType.map((e) => DropdownMenuItem(value:e[1] ,child: Text(e[0].toString()),)).toList(),
                        onChanged: (val){
                          setState(() {
                            widget.fieldType = val.toString();
                            (val == "text")? widget.responsetype = "نص": widget.responsetype = "رقم";
                            //initSelection = e[0].toString();
                          });
                        },

                    ),
                ],
              ),
              const SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: MyFild(
                  leftPadding: 20.0,
                  rightPadding: 20.0,
                  contorller:widget.noteController,
                  hintText: "ملاحظة للمستخدم عن السؤال",
                  obscure: false,
                  lable: const Text("ملاحظة للمستخدم عن السؤال"),
                  readOnly: false,
                  color: Colors.white,
                  sidesColor: Colors.black38,

                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        )
      ),
    );
  }


}
