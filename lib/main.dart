import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/blocObserver.dart';
import 'package:shop_app/shared/comonents/constants.dart';
import 'package:shop_app/shared/network/local/cachHelper.dart';
import 'package:shop_app/shared/network/remote/dioHelper.dart';
import 'package:shop_app/shared/style/Theme.dart';
import 'package:shop_app/shared/style/Theme.dart';
import 'package:shop_app/shared/style/Theme.dart';
import 'package:shop_app/shared/style/Theme.dart';
import 'package:shop_app/shared/style/Theme.dart';

import 'ShopApp/login/shop_loginScreen.dart';
import 'ShopApp/on_bording/on_bording_Screen.dart';
import 'ShopApp/shop_layout/cubit/cubit.dart';
import 'ShopApp/shop_layout/cubit/states.dart';
import 'ShopApp/shop_layout/shop_ayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  //================ThemeData with SharedPreference====================
  // bool? isDark = CachHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CachHelper.getData(key: 'onBoarding');

  token = CachHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null){
    if(token != null ){
      widget = ShopLayout();
    }else{
      widget = ShopLoginScreen();
    }
  }else{
    widget = onBoardingScreen();
  }

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;

  MyApp(
      this.startWidget,
      );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider( create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoris()..getFav(),)
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
          listener: (context , state){},
          builder: (context , state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme ,
              home: startWidget,
            );
          }
      ),
    );
  }
}


