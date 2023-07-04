import 'package:flutter/material.dart';
import 'package:home_services/Home%20Page/Drawer/Widget/fecth_services_data.dart';



// ignore: must_be_immutable
class MultiLevelDropDown extends StatelessWidget {
  var title;
  List categoryList;
  var user;
  MultiLevelDropDown({Key? key,this.title,required this.categoryList,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.category,color: Colors.blue,),
      expandedAlignment: Alignment.topRight,
      title:Text(title,style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black
    )),
      children: [
        for(int i=0;i<categoryList.length;i++)Padding(
          padding: const EdgeInsets.only(right: 25,bottom: 20),
          child: InkWell(child:Text(categoryList[i][1].toString(),style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ) ,),
            onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetThisCategoryServices(categoryName: categoryList[i][1],user: user,)));
          },),
        ),
      ],
    );
  }
}
