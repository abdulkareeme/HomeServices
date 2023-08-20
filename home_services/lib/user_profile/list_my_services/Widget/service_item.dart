import 'package:flutter/material.dart';
import 'package:home_services/style/list_my_services.dart';

import '../../../Main Classes/service.dart';


// ignore: must_be_immutable
class ServiceItem extends StatelessWidget {
  Service service;
   // ignore: prefer_typing_uninitialized_variables
   var user,onTap;
   ServiceItem({
     required this.service,
     this.user,
     this.onTap,
     super.key
  });
  double x= 3.4;
  @override
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: (
              Card(
                elevation: 8,
                child: InkWell(
                  onTap:onTap,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage:NetworkImage(service.photo),
                          radius: 60,
                        ),
                        Text(service.title,style: ListMyServicesStyle.titleStyle(),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            const Icon(Icons.auto_fix_off),
                            const SizedBox(width: 5,),
                            Text(service.category.name,style: ListMyServicesStyle.categoryStyle(),),

                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for(int i=0;i<service.rating.toInt();i++)const Icon(Icons.star,color: Colors.yellow,),
                            for(int i=0;i<5-service.rating.toInt();i++)const Icon(Icons.star_outline,color: Colors.yellow,),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Text("تبدأ من : ",style: ListMyServicesStyle.priceWordStyle()),
                            Text("${service.hourPrice} \$",style: ListMyServicesStyle.priceStyle(),),
                          ],
                        ),
                        const Text("متوفر في :"),
                        Wrap(
                          spacing: 8.0, // space between tags
                          runSpacing: 4.0, // space between lines
                          children:  [
                            for(int i=0;i<service.areaList.length;i++)Chip(label: Text(service.areaList[i].name)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        );
  }
}
