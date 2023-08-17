import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/send_finish_respond.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;


// ignore: must_be_immutable
class UnderwayOrderItem extends StatefulWidget {
  Order? order;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  UnderwayOrderItem({Key? key,required this.order,required this.user}) : super(key: key);

  @override
  State<UnderwayOrderItem> createState() => _UnderwayOrderItemState();
}

class _UnderwayOrderItemState extends State<UnderwayOrderItem> {
  String orderStatus = "";
  Color statusColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    switch (widget.order!.status) {
      case "Rejected":
        setState(() {
          orderStatus = "تم رفض الطلب";
          statusColor = Colors.red;
        });
        break;
      case "Under review":
        setState(() {
          orderStatus = "قيد مراجعة البائع";
          statusColor = Colors.grey;
        });
        break;
      case "Pending":
        setState(() {
          orderStatus = "قيد الانتظار...";
          statusColor = Colors.black;
        });
        break;
      case "Expire":
        setState(() {
          orderStatus = "تم الانتهاء";
          statusColor = Colors.green;
        });
        break;
      case "Underway":
        setState(() {
          orderStatus = "قيد التنفيذ";
          statusColor = Colors.orange;
        });
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Directionality(
          textDirection:ui.TextDirection.rtl,
          child: Card(
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child:Text(widget.order!.homeService.title,style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0,top: 6),
                  child:Text(widget.order!.firstName+" "+widget.order!.lastName,style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0,top: 4),
                  child: Text(DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(widget.order!.createDate)),style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0,top: 4,bottom: 10),
                  child:Text(orderStatus,style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green
                      ),
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("انهاء الخدمة ؟"),
                            content: Text.rich(TextSpan(
                                text: "سيتم اعلام الزبون بانتهائك من الخدمة وسيتيح له امكانة تقييم الخدمة واضافة تعليق"
                            )),
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendFinishAnswer(
                                    user:widget.user ,
                                    id: widget.order!.id,
                                  )));
                                },
                                child: const Text('انهاء'),
                              ),
                            ],
                          );
                        });

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.done_outline_rounded),
                          SizedBox(width: 5,),
                          Text("إنهاء الخدمة",style: TextStyle(fontSize: 20),)
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
