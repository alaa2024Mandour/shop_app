import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopApp/login/cubit/status.dart';


import '../../../../shared/network/endPoints.dart';
import '../../../shared/network/remote/dioHelper.dart';
import '../../models/loginModel/loginModel.dart';

class ShopLoginCubit extends Cubit <ShopLoginStatus>{
  ShopLoginCubit()  : super(ShopLoginInitialStatus());

  late ShopLoginModel loginModel ;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin ({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingStatus());

    DioHelper.postData(
        url: LOGIN,
        data: {
            'email':email,
            'password':password,
        },
      lang: 'en'
    ).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopLoginSucccessStatus(loginModel));
          print(loginModel.status);
          print(loginModel.message);
          print(loginModel.data.token);
    }).catchError((erorr){
      emit(ShopLoginErorrStatus(erorr.toString()));
    });

  }

  //===========password login form =============
  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffixIcon=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePassStatus());
  }
}