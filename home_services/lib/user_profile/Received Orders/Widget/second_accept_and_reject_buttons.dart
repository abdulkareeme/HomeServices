import 'package:flutter/material.dart';
import 'package:home_services/Main%20Classes/form.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/send_accept_after_review.dart';
import 'package:home_services/user_profile/Received%20Orders/Widget/send_reject_after_review.dart';
import 'package:home_services/user_profile/Sent%20Orders/Screen/form_review.dart';
class SecondAcceptAndRejectButtons extends StatelessWidget {
  var user,orderId;
  List<Form1> formList;
  SecondAcceptAndRejectButtons({Key? key,required this.user,required this.orderId,required this.formList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FormReviewPage(forms: formList,)));
        }, child: const Text("تصفح فورم الطلب")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
                onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text("قبول الطلب ؟"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendAcceptAfterReview(user: user, id: orderId)));

                          },
                          child: const Text('قبول'),
                        ),
                      ],
                    );
                  });
                  },
                child: const Text("قبول الطلب")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
                onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text("رفض الطلب ؟"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendRejectAfterReview(orderId: orderId, user: user)));

                          },
                          child: const Text('رفض'),
                        ),
                      ],
                    );
                  });
                },
                child: const Text("رفض الطلب")),
          ],
        )
      ],
    );
  }
}
