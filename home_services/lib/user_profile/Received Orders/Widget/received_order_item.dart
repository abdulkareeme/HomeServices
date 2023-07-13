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
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(right: 0,top: 6),
                    child:Text(widget.order!.clientName,style: const TextStyle(
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
                    child:Text(widget.order!.status,style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: (widget.order!.status == "Rejected")?Colors.red : Colors.grey,
                    ),),
                  ),
                  const SizedBox(height: 10,),
                  /*FirstAcceptAndRejectButtons(
                    user: widget.user,
                    orderId: widget.order!.id,
                  )*/
                  if(widget.order!.status == "Pending")FirstAcceptAndRejectButtons(order: widget.order,user: widget.user, orderId: widget.order!.id),
                  if(widget.order!.status == "Under review")SecondAcceptAndRejectButtons(user: widget.user,orderId: widget.order!.id,formList: widget.order!.formList),
                ],
              ),
        ),
      ),
    );
  }
}
