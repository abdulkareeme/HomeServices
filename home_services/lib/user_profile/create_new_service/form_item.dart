import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';

// ignore: must_be_immutable
class FormItem extends StatefulWidget{
  var formList,index;
  FormItem({
    required this.index,
    required this.formList,
    super.key
});
  @override
  State<StatefulWidget> createState() => _FormItemState();

  TextEditingController questionController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String fieldType = "text";
  var initSelection = "نص";
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
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(),left: BorderSide(),right: BorderSide(),bottom: BorderSide(),)
          ),
          //padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    print(widget.index);
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Failed to sign up'),
                        content: Text("اكيد بدك تحذف"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('CANCEL'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.vis = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
                  }, icon: const Icon(Icons.delete))
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
                      hintText: "adf",
                      obscure: false,
                      lable: const Text("adf"),
                      readOnly: false,
                      color: Colors.white,
                      sidesColor: Colors.black,
                      maxLine: 5,
                      maxLetters: 50,
                    ),
                  ),
                  DropdownButton(
                      hint: Text(widget.initSelection),
                        items:fieldsType.map((e) => DropdownMenuItem(value:e[1] ,child: Text(e[0].toString()),)).toList(),
                        onChanged: (val){
                          setState(() {
                            widget.fieldType = val.toString();
                            (val == "text")? widget.initSelection = "نص": widget.initSelection = "رقم";
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
                  sidesColor: Colors.black,

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
