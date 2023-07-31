import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Widget/get_user_details.dart';
import 'package:home_services/Main%20Classes/rating.dart';

// ignore: must_be_immutable
class HomeServiceRateItem extends StatelessWidget {
  HomeServiceRating op;
  HomeServiceRateItem({Key? key,required this.op}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(op.rattingTime));
    final hours = difference.inHours;
    final days = difference.inDays;
    final minutes = difference.inMinutes.remainder(60);
    final months = days/30;
    final years = months/12;
    List op1 = [[years.toInt(),"${years.toInt()} سنة "],[months.toInt(),"${months.toInt()} شهر "],[days,"$days يوم "],[hours,"$hours ساعة "],[minutes,"$minutes دقيقة "]];
    String duration ="";
    for(int i=0;i<op1.length;i++){
      if(op1[i][0]!=0){
        duration = op1[i][1];
        break;
      }
    }
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(op.homeServiceTitle,style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(op.category,style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("جودة العمل : ",style: TextStyle(
                      fontSize: 18,
                    ),),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        for(int i=0;i<op.qualityOfService.toInt();i++)const Icon(Icons.star,color: Colors.yellow,),
                        for(int i=0;i<5-op.qualityOfService.toInt();i++)const Icon(Icons.star_outline,color: Colors.yellow,)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("الالتزام بالمواعيد : ",style: TextStyle(
                      fontSize: 18,
                    ),),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        for(int i=0;i<op.commitmentToDeadline.toInt();i++)const Icon(Icons.star,color: Colors.yellow,),
                        for(int i=0;i<5-op.commitmentToDeadline.toInt();i++)const Icon(Icons.star_outline,color: Colors.yellow,)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("أخلاقيات العمل : ",style: TextStyle(
                      fontSize: 18,
                    ),),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        for(int i=0;i<op.workEthics.toInt();i++)const Icon(Icons.star,color: Colors.yellow,),
                        for(int i=0;i<5-op.workEthics.toInt();i++)const Icon(Icons.star_outline,color: Colors.yellow,)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 0,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:   [
                    InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetUserDetails(username: op.clientUserName)));
                      },
                      child:  CircleAvatar(
                        radius: 50,

                        // required user photo
                        backgroundImage: NetworkImage(op.photo),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetUserDetails(username: op.clientUserName)));
                          },
                          child:  Text("${op.clientFirstName} ${op.clientLastName}",style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.person,color:Color.fromRGBO(170, 170, 170, 1),size: 20,),
                                SizedBox(width: 4,),
                                Text("مشتري",style: TextStyle(
                                  color: Color.fromRGBO(170, 170, 170, 1),

                                ),),
                              ],
                            ),
                            const SizedBox(width: 25,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                const Icon(Icons.watch_later,color:Color.fromRGBO(170, 170, 170, 1),size: 17,),
                                const SizedBox(width: 4,),
                                Text(duration,style: const TextStyle(
                                  color: Color.fromRGBO(170, 170, 170, 1),
                                ),),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                children: const [
                  Padding(
                    padding:  EdgeInsets.only(right: 22,),
                    child: Text(
                      "التعليقات : ",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )
                    ,),
                              ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right:10,bottom: 15,left: 10),
                child:Text.rich(
                    textAlign: TextAlign.justify,
                    TextSpan(
                  text: op.clientComment,style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
