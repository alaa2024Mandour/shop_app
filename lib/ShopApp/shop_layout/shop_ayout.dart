import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/comonents/components.dart';
import '../Search/searc_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},

      builder:(context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "Salla",
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                      Icons.search,
                    color: Colors.black,
                  ),)
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeNavBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,),
                label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps,),
                  label: "Categories"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite,),
                  label: "Favorites"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings,),
                  label: "Settings"
              ),
            ],

          ),
        );
      }
    );
  }
}
