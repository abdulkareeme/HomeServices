import 'package:flutter/material.dart';

import '../../Main Classes/service.dart';


// ignore: must_be_immutable
class ShowServiceItem extends StatelessWidget {
  Service service;
  ShowServiceItem({Key? key,required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        child: Card(
          elevation: 4,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Text(service.title,style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(height: 10,),
                    Text(service.category.name,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
