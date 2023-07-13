import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Sent%20Orders/Widget/order_item.dart';


// ignore: must_be_immutable
class MySentOrder extends StatefulWidget {
  List<Order?> orders;
  var user;
  MySentOrder({Key? key,required this.orders,required this.user}) : super(key: key);

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
          child:SingleChildScrollView(
            child: Column(
              children: [
                for(int i=0;i<widget.orders.length;i++)OrderItem(order: widget.orders[i],forms: widget.orders[i]!.formList,user: widget.user),
              ],
            ),
          )
        ),
      ),
    );
  }
}
