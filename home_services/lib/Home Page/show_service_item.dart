import 'package:flutter/material.dart';

import '../Main Classes/service.dart';

class ShowServiceItem extends StatelessWidget {
  Service service;
  ShowServiceItem({Key? key,required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 100,
      height: 100,
      child: Row(
        children: [
          Text(service.title),
        ],
      ),
    );
  }
}
