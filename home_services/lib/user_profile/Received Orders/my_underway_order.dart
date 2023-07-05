import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/underway_orders_item.dart';
class MyUnderwayOrders extends StatefulWidget {
  List<Order?> orders;
  // ignore: prefer_typing_uninitialized_variables
  var user;
   MyUnderwayOrders({Key? key,required this.user,required this.orders}) : super(key: key);

  @override
  State<MyUnderwayOrders> createState() => _MyUnderwayOrdersState();
}

class _MyUnderwayOrdersState extends State<MyUnderwayOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
            textDirection: TextDirection.rtl,
            child:SingleChildScrollView(
              child: Column(
                children: [
                  for(int i=0;i<widget.orders.length;i++)if(widget.orders[i]!.status == "Underway")UnderwayOrderItem(order: widget.orders[i], user: widget.user),
                ],
              ),
            )
        ),
      ),
    );
  }
}
