import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/underway_orders_item.dart';
// ignore: must_be_immutable
class MyUnderwayOrders extends StatefulWidget {
  List<Order?> orders;
  // ignore: prefer_typing_uninitialized_variables
  var user;
   MyUnderwayOrders({Key? key,required this.user,required this.orders}) : super(key: key);

  @override
  State<MyUnderwayOrders> createState() => _MyUnderwayOrdersState();
  bool isTheOrdersListEmpty = true;
}

class _MyUnderwayOrdersState extends State<MyUnderwayOrders> {

  @override
  void initState() {
    print("object");
    bool haveToBreak= false;
    for(int i=0;i<widget.orders.length;i++){
      print(widget.orders.length);
      print(widget.orders[i]!.status);
      if(widget.orders[i]!.status == "Underway"){
        setState(() {
          widget.isTheOrdersListEmpty = false;
          haveToBreak = true;
        });
        if(haveToBreak)break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("الطلبات قيد التنفيذ"),
            backgroundColor: Colors.grey[700],
          ),
          body:(widget.isTheOrdersListEmpty == true)? const Center(child: Text("لا توجد خدمات قيد التنفيذ حاليا",style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 28,
                  color: Colors.black26
              ),),):SingleChildScrollView(
                child:Column(
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
