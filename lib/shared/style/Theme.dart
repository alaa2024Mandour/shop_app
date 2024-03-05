 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[800],
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w900,
          color: Colors.white
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 25,
      ),
      backgroundColor: Colors.grey[800],
      elevation: 0.0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.grey[800],
      elevation: 25.0,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white
        )
    ),
  fontFamily: 'Cracker',
);

 ThemeData lightTheme =ThemeData(
     primarySwatch: Colors.blue,
     scaffoldBackgroundColor: Colors.white,
     appBarTheme: AppBarTheme(
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
       ),
       titleTextStyle: TextStyle(
           fontSize: 25,
           fontWeight: FontWeight.w900,
           color: Colors.black
       ),
       iconTheme: IconThemeData(
         color: Colors.black,
         size: 25,
       ),
       backgroundColor: Colors.white,
       elevation: 0.0,
     ),
     floatingActionButtonTheme: FloatingActionButtonThemeData(
       backgroundColor: defultColor,
     ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
       type: BottomNavigationBarType.fixed,
       selectedItemColor: defultColor,
       backgroundColor: Colors.white,
       elevation: 25.0,
     ),
     textTheme: TextTheme(
         bodyText1: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w900,
             color: Colors.black
         ),

     ),
   fontFamily: 'Cracker',
 );