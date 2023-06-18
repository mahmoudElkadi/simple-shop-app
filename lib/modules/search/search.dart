import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../model/searchModel.dart';
import '../../shared/styles/color.dart';

class SearchScreen extends StatelessWidget {
var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcupit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('Bazar',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefixIcon:Icons.search,
                  kind: 'Search',
                  onChange: (value){
                    Shopcupit.get(context).searchProduct(text: value);
                  }
                ),
                SizedBox(height: 10,),
                if(state is ShopSearchLoadingState)
                  LinearProgressIndicator(),
                  if(state is ShopSearchSuccessState)
            Expanded(
              child: ListView.separated(
              itemBuilder: (BuildContext context, int index)=>buildProductList(Shopcupit.get(context).searchModel?.data?.data?[index],context,oldPrice: false),
              separatorBuilder: (BuildContext context, int index) =>MyDivider(),
              itemCount: Shopcupit.get(context).searchModel!.data!.data!.length,),
              ),

              ],
            ),

          ),
        );
      },
    );
  }


}
