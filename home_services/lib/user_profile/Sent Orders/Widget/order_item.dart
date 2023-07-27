// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/form.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Sent%20Orders/Screen/form_review.dart';
import 'package:home_services/user_profile/Sent%20Orders/Widget/cancel_order.dart';
import 'package:home_services/user_profile/rating/Screen/rate_service.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OrderItem extends StatefulWidget {
  Order? order;
  List<Form1> forms;
  var user;
  var reviceOrderForm;

  OrderItem(
      {Key? key,
      required this.order,
      required this.forms,
      required this.user,
      this.reviceOrderForm})
      : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
  bool acceptReceiveOrder = true;
  bool receivedOrderForm = false;
}

class _OrderItemState extends State<OrderItem> {
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Text(
                widget.order!.homeService.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 0, top: 6),
                child: Text(
                  widget.order!.sellerFirstName+" "+widget.order!.sellerLastName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 0, top: 4),
              child: Text(
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(widget.order!.createDate)),
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0, top: 4, bottom: 2),
              child: Text(
                orderStatus,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FormReviewPage(forms: widget.forms)));
                },
                child: const Text("مراجعة فورم الطلب")),
            const SizedBox(
              height: 6,
            ),
            if(widget.order!.isRateable == true && widget.order!.status == "Expire")ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.only(left: 39,right: 39)
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RateThisService(
                    user: widget.user,
                    orderId: widget.order!.id,
                  )));
                }, child: const Text("تقييم البائع")),



            if(widget.order!.isRateable == true && widget.order!.status == "Underway")Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RateThisService(
                      user: widget.user,
                      orderId: widget.order!.id,
                    )));
                  },
                  child: const Text("انهاء الخدمة وتقييم البائع")),
            ),
            if(widget.order!.isRateable == false && widget.order!.status == "Pending")ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Colors.red,
                  padding: const EdgeInsets.only(left: 22,right: 22)
                ),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CancelOrder(user: widget.user, orderId: widget.order!.id)));
                }, child:const Text("التراجع عن الطلب")),
          ],
        ),
      ),
    );
  }
}
