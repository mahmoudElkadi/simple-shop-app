import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/color.dart';


ThemeData darkTheme=ThemeData(

  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      backgroundColor: HexColor('333739'),
      toolbarTextStyle:TextStyle(
          color: Colors.white
      ) ,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white10,
          statusBarBrightness: Brightness.dark
      ),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation:20,
      backgroundColor: HexColor('333739')


  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )
  ),
    fontFamily: 'jannah',

  scaffoldBackgroundColor:HexColor('333739'),
);

ThemeData lightTheme=ThemeData(

  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      backgroundColor: Colors.white10,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white10,
          statusBarBrightness: Brightness.dark
      ),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation:20,
      backgroundColor: Colors.white


  ),
  textTheme: TextTheme(

    bodyText1: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
  ),
  fontFamily: 'Jannah',



);