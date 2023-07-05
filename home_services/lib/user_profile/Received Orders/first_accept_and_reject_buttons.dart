import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/order.dart';
import 'package:home_services/user_profile/Received%20Orders/send_first_acceptance.dart';
import 'package:home_services/user_profile/Received%20Orders/send_first_reject.dart';

// ignore: must_be_immutable
class FirstAcceptAndRejectButtons extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var user,orderId;
  Order? order;
  FirstAcceptAndRejectButtons({Key? key,required this.user,required this.orderId,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendFirstAcceptance(id: orderId, user: user,order: order,)));
            },
            child: const Text("قبول الطلب")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendFirstReject(user: user, orderId: orderId)));
            },
            child: const Text("رفض الطلب"))
      ],
    );
  }
}
