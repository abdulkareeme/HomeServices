import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/first_accept_and_reject_buttons.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/second_accept_and_reject_buttons.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class ReceivedOrderItem extends StatefulWidget {
  Order? order;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  ReceivedOrderItem({Key? key,required this.order,required this.user}) : super(key: key);

  @override
  State<ReceivedOrderItem> createState() => _ReceivedOrderItemState();
}

class _ReceivedOrderItemState extends State<ReceivedOrderItem> {
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
        child: Card(
          child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child:Text(widget.order!.homeService.title,style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0,top: 0),
                    child:Text(widget.order!.firstName+" "+widget.order!.lastName,style: const TextStyle(
                        fontSize: 20,
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
                  Visibility(
                    visible: (widget.order!.status == "Pending")? false:true,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0,top: 4,bottom: 10),
                      child:Text(orderStatus,style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color:statusColor,
                      ),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(widget.order!.status == "Pending")FirstAcceptAndRejectButtons(order: widget.order,user: widget.user, orderId: widget.order!.id),
                  if(widget.order!.status == "Under review")SecondAcceptAndRejectButtons(user: widget.user,orderId: widget.order!.id,formList: widget.order!.formList),
                  const SizedBox(height: 7,)
                ],
              ),
        ),
      ),
    );
  }
}
