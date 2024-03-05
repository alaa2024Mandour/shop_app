
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/comonents/components.dart';

import '../../shared/style/colors.dart';
import '../models/categoriesMode/categories_model.dart';
import '../models/homeModel/home_model.dart';
import '../shop_layout/cubit/cubit.dart';
import '../shop_layout/cubit/states.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if (!state.Model.status){
            showToast(msg: state.Model.message, state: ToastStates.ERROR);
          }else{
            showToast(msg: state.Model.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context,status) {
        return
          ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesMode !=null,
            builder: (context) => productBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesMode!,context),
            fallback: (context) => Center(child: CircularProgressIndicator(),));
      }
    );
  }

  Widget productBuilder (HomeModel model , CategoriesMode categoriesMode,context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items:model.data.banners.map((e) => Image(
                  image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              )).toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              )),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>buildCategories(categoriesMode.data!.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                      itemCount: categoriesMode.data!.data.length)
                ),
                SizedBox(height: 20,),
                Text(
                  "New Products",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.58,
              children: List.generate(
                  model.data.products.length,
                    (index) => buildGridProduct( model.data.products[index],context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategories(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100.0,
        child: Text(
          "${model.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductsModel model , context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: defultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount!=0)
                  Text(
                    '${model.oldPrice.round()}',
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
                        ShopCubit.get(context).chandeFavorites(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                          radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]!? defultColor : Colors.grey,
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
  );
}
