import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/received_order_item.dart';

// ignore: must_be_immutable
class MyReceivedOrders extends StatefulWidget {
  List<Order?> orders;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  var formList;
  MyReceivedOrders({Key? key,required this.orders,required this.user,this.formList}) : super(key: key);
  @override
  State<MyReceivedOrders> createState() => _MyReceivedOrdersState();
}

class _MyReceivedOrdersState extends State<MyReceivedOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: const Text("الطلبات الواصلة"),
          ),
          body: SingleChildScrollView(
                child: Column(
                  children: [
                    (widget.orders.isEmpty)? const Center(child: Text("ليس لديك طلبات حاليا",style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 28,
                      color: Colors.white70
                    ),),) : Container(),
                    for(int i=0;i<widget.orders.length;i++)if(widget.orders[i]!.status == "Pending" || widget.orders[i]!.status =="Under review" || widget.orders[i]!.status =="Rejected"|| widget.orders[i]!.status == "Expire")ReceivedOrderItem(order: widget.orders[i], user: widget.user),

                  ],
                ),
              )
        ),
      ),
    );
  }
}
