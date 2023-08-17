import 'package:flutter/material.dart';
import 'package:home_services/my_field.dart';
import 'package:home_services/user_profile/rating/Widget/send_service_rate.dart';


class RateThisService extends StatefulWidget {
  var user;
  int orderId;
  RateThisService({Key? key,required this.user,required this.orderId}) : super(key: key);

  @override
  State<RateThisService> createState() => _RateThisServiceState();
}

class _RateThisServiceState extends State<RateThisService> {
  List quality = [false,false,false,false,false,];
  List deadLine = [false,false,false,false,false,];
  List ethical = [false,false,false,false,false,];
  TextEditingController comment = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool formState(){
    var op = formKey.currentState;
    return op!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: const Text("تقييم الخدمة"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 200,),
                Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("جودة العمل : ",style: TextStyle(
                        fontSize: 18,
                      ),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for(int i=0;i<5;i++)IconButton(onPressed: (){
                            for(int j=0; j<=i;j++){
                              setState(() {
                                quality[j] = true;
                              });
                            }
                            for(int j=i+1; j<5;j++){
                              setState(() {
                                quality[j] = false;
                              });
                            }
                          }, icon: (quality[i] == false)?const Icon(Icons.star_outline,color: Colors.yellow,) :const Icon(Icons.star,color: Colors.yellow,) )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14,right:9,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("الالتزام بالمواعيد : ",style: TextStyle(
                        fontSize: 18,
                      ),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for(int i=0;i<5;i++)IconButton(onPressed: (){
                            for(int j=0; j<=i;j++){
                              setState(() {
                                deadLine[j] = true;
                              });
                            }
                            for(int j=i+1; j<5;j++){
                              setState(() {
                                deadLine[j] = false;
                              });
                            }
                          }, icon: (deadLine[i] == false)?const Icon(Icons.star_outline,color: Colors.yellow,) :const Icon(Icons.star,color: Colors.yellow,) )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("أخلاقيات العمل : ",style: TextStyle(
                        fontSize: 18,
                      ),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for(int i=0;i<5;i++)IconButton(onPressed: (){
                            for(int j=0; j<=i;j++){
                              setState(() {
                                ethical[j] = true;
                              });
                            }
                            for(int j=i+1; j<5;j++){
                              setState(() {
                                ethical[j] = false;
                              });
                            }
                          }, icon: (ethical[i] == false)?const Icon(Icons.star_outline,color: Colors.yellow,) :const Icon(Icons.star,color: Colors.yellow,) )
                        ],
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyFild(
                        color:Colors.white ,
                        sidesColor: Colors.black,
                        rightPadding: 20.0,
                        leftPadding: 20.0,
                        hintText: "تعليقك على الخدمة",
                        readOnly: false,
                        contorller: comment,
                        lable: const Text("تعليقك على الخدمة"),
                        obscure: false,
                        val: (_){
                          if(comment.text.isEmpty){
                            return "required" ;
                          } else {
                            return null;
                          }
                        },
                      )
                    ],
                  ),
                ),
                ElevatedButton(onPressed: (){
                  int quality1=0, deadLine1= 0,ethical1= 0;
                  for(int i=0;i<quality.length;i++){
                    if(quality[i] == true)quality1++;
                  }
                  for(int i=0;i<deadLine.length;i++){
                    if(deadLine[i] == true)deadLine1++;
                  }
                  for(int i=0;i<ethical.length;i++){
                    if(ethical[i] == true)ethical1++;
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendUserRate(
                    orderId: widget.orderId,
                    user: widget.user,
                    comment: comment,
                    deadLine: deadLine1,
                    ethical: ethical1,
                    quality: ethical1,
                  )));
                }, child: const Text("تعليق"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
