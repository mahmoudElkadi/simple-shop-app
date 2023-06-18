import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/cubit/AppCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';


class ShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>Shopcupit()..getFavorites()..getHomeData()..getUserDAta()..getGategoryData(),
      child: BlocConsumer<Shopcupit,ShopState>(
        listener: (context,state){},
          builder: (context,state){
          return
            Scaffold(
            appBar: AppBar(
              title: Text(
                  'Bazar',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: (){
                    AppCubit.get(context).changeMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: Shopcupit.get(context).Screens[Shopcupit.get(context).currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex:Shopcupit.get(context).currentIndex ,
              onTap: (index){
                Shopcupit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings'
                ),
              ],

            ),


          );
          },

      ),
    );

  }
}
