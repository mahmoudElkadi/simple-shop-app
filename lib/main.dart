import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/remote/dio_helper.dart';
import 'package:shop_app/layout/shopApp.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/component/constans.dart';
import 'package:shop_app/shared/cubit/AppCubit.dart';
import 'package:shop_app/shared/cubit/Bloc_observer.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/shopLoginCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'Network/local/shared_helper.dart';
import 'modules/onBoarding/onBoardingScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
   dynamic isDark=CacheHelper.getData(key: 'mode');
   token=CacheHelper.getData(key: 'token');
  dynamic onBoarding=CacheHelper.getData(key:'onBoarding');
   if (onBoarding !=null)
     {
       if(token != null)widget=ShopScreen();
       else widget=LoginScreen();
     }else{
     widget =OnBoardingScreen();
   }
   print (isDark);

  runApp(MyApp(
    isDark,
      startWidget:widget
  ));
}

class MyApp extends StatelessWidget {
final Widget startWidget;
final dynamic isDark;
 MyApp(this.isDark,
{required this.startWidget}
);


  // This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (context)=>ShopLoginCubit()),
    BlocProvider(create: (context)=>AppCubit()..changeMode(isDark:isDark )),
    BlocProvider(create: (context)=>Shopcupit()..getGategoryData()..getHomeData()..getFavorites()..getUserDAta()),

  ],
      child: BlocConsumer<AppCubit,AppState>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false ,
              title: 'Flutter Demo',
              theme:lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).mode? ThemeMode.light:ThemeMode.dark ,
              home: startWidget,
            );
          })
  );
}
}


