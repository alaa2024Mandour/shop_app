import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopApp/models/fav_model/fav_model.dart';
import '../../shared/comonents/components.dart';
import '../../shared/style/colors.dart';
import '../shop_layout/cubit/cubit.dart';
import '../shop_layout/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (BuildContext context) => ListView.separated(
              itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favModels!.data!.data![index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).favModels!.data!.data!.length),
          fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),

        );
      },
      listener: (BuildContext context, Object? state) =>{},
    );;
  }

  Widget buildFavItem(FavData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.product!.image}'),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if(model.product!.discount !=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 10.0,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width:20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.product!.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price.toString()}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: defultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(1!=0)
                      Text(
                        '${model.product!.oldPrice.toString()}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).chandeFavorites(model.product!.id ??0);
                          print(model.product!.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.product!.id]!? defultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
