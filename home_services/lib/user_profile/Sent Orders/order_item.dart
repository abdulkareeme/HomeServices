import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/form.dart';
import 'package:home_services/user_profile/Received%20Orders/send_first_reject.dart';
import 'package:home_services/user_profile/Sent%20Orders/cancel_order.dart';
import 'package:home_services/user_profile/Sent%20Orders/form_review.dart';
import 'package:intl/intl.dart';

import '../../Main Classes/order.dart';


// ignore: must_be_immutable
class OrderItem extends StatefulWidget {
  Order? order;
  List<Form1> forms;
  var user;
  bool isItReceive;
  OrderItem({Key? key,required this.order,required this.forms,required this.user,required this.isItReceive}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    for(int i=0;i<widget.forms.length;i++){
      print(widget.forms[i].field.title);
      print(widget.forms[i].content);
    }
    return Card(
      elevation: 5,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child:Text(widget.order!.homeService.title,style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                    ),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 6),
                child: (widget.isItReceive == false)? Text(widget.order!.homeService.creatorUserName,style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    ),) : Text(widget.order!.clientName,style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 4),
                child: Text(DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(widget.order!.createDate)),style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    ),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 4,bottom: 10),
                child:Text(widget.order!.status,style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: (widget.order!.status == "Rejected")?Colors.red : Colors.grey,
                    ),),
              ),
              const SizedBox(height: 10,)
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FormReviewPage(forms: widget.forms)));
              }, child:const Text("مراجعة فورم الطلب")),
              const SizedBox(height: 5,),
              (widget.isItReceive == true)? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: (){

                      },
                      child: const Text("قبول الطلب")),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder:(context)=> SendFirstReject(user: widget.user, orderId: widget.order!.id)));
                      },
                      child: const Text("رفض الطلب")),
                ],
              ) :(widget.order!.status != "Rejected")? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:Colors.red,
                  ),
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CancelOrder(user: widget.user, orderId: widget.order!.id)));
                  }, child:const Text("التراجع عن الطلب")):IgnorePointer(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey
                  ),
                  onPressed: null , child:const Text("التراجع عن الطلب"),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
