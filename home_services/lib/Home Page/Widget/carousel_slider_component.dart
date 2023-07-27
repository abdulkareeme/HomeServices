import 'package:flutter/material.dart';

class CarouselSliderComponent extends StatelessWidget {
  String imageUrl,text;
  CarouselSliderComponent({Key? key,required this.text,required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image(image:AssetImage(imageUrl,),width: 500,)),
        const SizedBox(height: 10,),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(text,style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black87
                ),),
          ),
        )

      ],
    );
  }
}
