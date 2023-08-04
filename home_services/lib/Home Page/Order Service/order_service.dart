import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Order%20Service/post_order.dart';
import 'package:home_services/Home%20Page/Order%20Service/service_form_item.dart';

// ignore: must_be_immutable
class OrderService extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var serviceForms;
  var user;
  var serviceid;
  OrderService({Key? key, required this.serviceForms,required this.user,required this.serviceid}) : super(key: key);

  @override
  State<OrderService> createState() => _OrderServiceState();
  List forms = [];
}

class _OrderServiceState extends State<OrderService> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    for (int i = 4; i < widget.serviceForms.length; i++) {
      ServiceItemForm ob = (widget.serviceForms[i].length == 4)
          ? ServiceItemForm(
              id: widget.serviceForms[i][0],
              title: widget.serviceForms[i][1],
              type: widget.serviceForms[i][2],
              note: widget.serviceForms[i][3],
              inFirstFour:false,
            )
          : ServiceItemForm(
              title: widget.serviceForms[i][1],
              type: widget.serviceForms[i][2],
              note: "",
              id: widget.serviceForms[i][0],
              inFirstFour:false,
      );
      widget.forms.add(ob);
    }
    super.initState();
  }
  bool formState(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  Widget build(BuildContext context) {
    List firstFour = [
      ServiceItemForm(
          inFirstFour: true,
          op: (val) {
            if(val.length == 0){
              return "required";
            } else {
              return null;
            }
          },
          id: widget.serviceForms[0][0],
          title: widget.serviceForms[0][1],
          type: widget.serviceForms[0][2],
          note: widget.serviceForms[0][3]),
      ServiceItemForm(
          inFirstFour: true,
          op: (val) {
            if(val.length == 0){
              return "required";
            } else {
              return null;
            }
          },
          id: widget.serviceForms[1][0],
          title: widget.serviceForms[1][1],
          type: widget.serviceForms[1][2],
          note: widget.serviceForms[1][3]),
      ServiceItemForm(
          inFirstFour: true,
          op: (val) {
            if(val.length == 0){
              return "required";
            } else {
              return null;
            }
          },
          id: widget.serviceForms[2][0],
          title: widget.serviceForms[2][1],
          type: widget.serviceForms[2][2],
          note: widget.serviceForms[2][3]),
      ServiceItemForm(
          inFirstFour: true,
          op: (data) {
            if(data.length == 0){
              return "required";
            } else {
              int number = int.parse(data);
              if(number >1 && number<=90){
                return null;
              } else {
                return "عدد الايام يجب ان يكون اكبر من 2 واصغر من 90";
              }
            }
          },
          id: widget.serviceForms[3][0],
          title: widget.serviceForms[3][1],
          type: widget.serviceForms[3][2],
          note: widget.serviceForms[3][3]),
    ];
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Form(
              key:formKey,
              child: Column(
                children: [
                  const Text(
                    "إملاء الحقول التالية",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  for(int i=0;i<firstFour.length;i++)firstFour[i],
                  for (int i = 0; i < widget.forms.length; i++) widget.forms[i],
                  ElevatedButton(onPressed: (){
                    if(formState()){
                      List data = [];
                      for(int i=0;i<firstFour.length;i++){
                        List o = [];
                        o.add(firstFour[i].geId());
                        o.add(firstFour[i].getController());
                        data.add(o);
                      }
                      for(int i=0;i<widget.forms.length;i++){
                        List o = [];
                        o.add(widget.forms[i].geId());
                        o.add(widget.forms[i].getController());
                        data.add(o);
                      }

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostOrder(
                        user: widget.user,
                        formAnswer: data,
                        serviceId: widget.serviceid,
                      )));
                    }
                  }, child: const Text("طلب الخدمة"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
