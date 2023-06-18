import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/changeFavoritesModel.dart';
import 'package:shop_app/model/favoritesModel.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../shared/component/component.dart';
import '../../shared/cubit/shopCubit.dart';
import '../../shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcupit,ShopState>(
        listener: (context,state){},
      builder: (context,state){
          return ConditionalBuilder(
            condition: state is ShopingGetLoadingFavorites,
            builder: (context)=>Center(child: CircularProgressIndicator()),
            fallback:(context)=>ListView.separated(
              scrollDirection : Axis.vertical,
              itemBuilder: (context,index)=>buildProductList(Shopcupit.get(context).favoritesModel?.data?.data?[index].product,context),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemCount: Shopcupit.get(context).favoritesModel!.data!.data!.length) ,
          );



      },
    );
  }

}

