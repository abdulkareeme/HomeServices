// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/form.dart';
import 'package:home_services/user_profile/Sent%20Orders/cancel_order.dart';
import 'package:home_services/user_profile/Sent%20Orders/form_review.dart';
import 'package:home_services/user_profile/rating/rate_service.dart';
import 'package:intl/intl.dart';

import '../../Main Classes/order.dart';


// ignore: must_be_immutable
class OrderItem extends StatefulWidget {
  Order? order;
  List<Form1> forms;
  var user;
  var reviceOrderForm;

  OrderItem({Key? key,required this.order,required this.forms,required this.user,this.reviceOrderForm}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
  bool acceptReceiveOrder = true;
  bool receivedOrderForm = false;
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
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
                child: Text(widget.order!.homeService.creatorUserName,style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    ),)
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
          (widget.order!.isRateable == false && widget.order!.status == "Expire")?Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:const [
              Icon(Icons.done_all,color: Colors.green,),
              Text("مكتملة",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.green
              ),)
            ],
          ) : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FormReviewPage(forms: widget.forms)));
                      }, child:const Text("مراجعة فورم الطلب")),

                  const SizedBox(height: 5,),
                  (widget.order!.status != "Rejected")? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:Colors.red,
                      ),
                      onPressed:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CancelOrder(user: widget.user, orderId: widget.order!.id)));
                      }, child:const Text("التراجع عن الطلب"))
                      : IgnorePointer(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey
                      ),
                      onPressed: null , child:const Text("التراجع عن الطلب"),
                    ),
                  ),
                  (widget.order!.isRateable == true && widget.order!.status == "Underway")? Padding(
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
                  ) : (widget.order!.isRateable == true && widget.order!.status == "Expire")? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.only(left: 32,right: 32)
                      ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RateThisService(
                          user: widget.user,
                          orderId: widget.order!.id,
                        )));
                      }, child: const Text("تقييم البائع")) : Container()

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
