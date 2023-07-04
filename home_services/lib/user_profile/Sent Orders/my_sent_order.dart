import 'package:flutter/material.dart';
import 'package:home_services/user_profile/Sent%20Orders/order_item.dart';

import '../../Main Classes/order.dart';

// ignore: must_be_immutable
class MySentOrder extends StatefulWidget {
  List<Order?> orders;
  var user;
  bool isItReceive;
  MySentOrder({Key? key,required this.orders,required this.user,required this.isItReceive}) : super(key: key);

  @override
  State<MySentOrder> createState() => _MySentOrderState();
}

class _MySentOrderState extends State<MySentOrder> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child:Column(
            children: [
              for(int i=0;i<widget.orders.length;i++)OrderItem(order: widget.orders[i],forms: widget.orders[i]!.formList,user: widget.user,isItReceive: widget.isItReceive),
            ],
          )
        ),
      ),
    );
  }
}
