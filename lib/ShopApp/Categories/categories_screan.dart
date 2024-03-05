import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../shared/comonents/components.dart';
import '../models/categoriesMode/categories_model.dart';
import '../shop_layout/cubit/cubit.dart';
import '../shop_layout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state) {
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesMode!.data!.data[index]),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).categoriesMode!.data!.data.length);
      },
      listener: (BuildContext context, Object? state) =>{},
    );
  }
}

Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Row(

    children: [

      Image(

        image: NetworkImage("${model.image}"),

        width: 80,

        height: 80,

        fit: BoxFit.cover,

      ),

      SizedBox(width:20.0),

      Text(

        "${model.name}",

        maxLines: 2,

        overflow: TextOverflow.ellipsis,

        style: TextStyle(

          fontSize: 20,

          fontWeight: FontWeight.w900,

        ),

      ),

      Spacer(),

      Icon(Icons.arrow_forward_ios),



    ],

  ),
);
