import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopApp/shop_layout/cubit/states.dart';


import '../../../../shared/comonents/constants.dart';
import '../../../../shared/network/endPoints.dart';
import '../../../shared/network/remote/dioHelper.dart';
import '../../Categories/categories_screan.dart';
import '../../Favorites/favoriets_screen.dart';
import '../../Products/products_screen.dart';
import '../../models/categoriesMode/categories_model.dart';
import '../../models/homeModel/home_model.dart';
import '../../settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeNavBottom (int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }


  HomeModel? homeModel ;
  Map<int,bool> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token:token
    ).then((value){

      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel!.data.banners[0].image);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesMode? categoriesMode ;

  void getCategoris(){
    DioHelper.getData(
        url: GET_CATEGORIES,
        token:token
    ).then((value){

      categoriesMode = CategoriesMode.fromJson(value.data);

      emit(ShopSuccessCategoriesState());

    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }


  void chandeFavorites(){
    
  }
}