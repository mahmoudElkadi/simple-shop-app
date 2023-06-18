import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../model/gategoriesModel.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcupit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            scrollDirection : Axis.vertical,
            itemBuilder: (context,index)=>buildCategoryItem(Shopcupit.get(context).gategoryModel?.data?.data[index]),
            separatorBuilder: (context,index)=>SizedBox(height: 20,),
            itemCount: Shopcupit.get(context).gategoryModel!.data!.data.length);
      },
    );
  }

  Widget buildCategoryItem(GategoryData? model)=>Padding(
    padding:EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: NetworkImage('${model?.image}'),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20,),
        Text('${model?.name}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900
          ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)

      ],
    ),
  );
}