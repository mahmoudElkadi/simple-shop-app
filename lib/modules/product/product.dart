import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/homeModel.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/color.dart';

import '../../model/gategoriesModel.dart';
import '../../shared/component/component.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    dynamic cubit1=Shopcupit.get(context);
    return BlocConsumer<Shopcupit,ShopState>(
        listener: (context,state){
          if (state is ShopingChangeFaavorites){
            if(state.favoritesModel.status ==false){
              showToast(
                  msg: '${state.favoritesModel.message}',
                  state:ToastStatus.ERROR ,
              );
            }
            if(state.favoritesModel.status ==true){
              showToast(
                  msg: '${state.favoritesModel.message}',
                  state:ToastStatus.SUCCESS ,
              );
            }


          }
        },
        builder: (context,state){
          return ConditionalBuilder(
              condition: cubit1.homeModel!=null && Shopcupit.get(context).gategoryModel != null,
              builder: (context)=>productsBuilder(Shopcupit.get(context).homeModel,Shopcupit.get(context).gategoryModel,context),
              fallback:(context)=>Center(child: CircularProgressIndicator()),

          );
        }
    );
  }


  Widget productsBuilder(HomeModel? model,GategoryModel? categoryModel,context)=>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),

              child: InkWell(
                onTap: (){},

                child:ClipRRect
                (
                  borderRadius: BorderRadius.circular(10),
                  child:CarouselSlider(
                    items:  model?.data?.banners.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage('${item.image}'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),).toList(),
                    options: CarouselOptions(
                      height: 250,
                      initialPage: 0,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds:1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal

        )
                ),)
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Categories',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.w800
                   ),),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>buildCategoryItem(categoryModel.data?.data[index]),
                          separatorBuilder: (context,index)=>SizedBox(width:20,),
                          itemCount: categoryModel!.data!.data.length),
                    ),
            Text('New Product',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                    ),),
                 ],
               ),
             ),
             SizedBox(height: 10,),
             Container(
               color: Colors.grey[300],
               child: GridView.count(
                 physics: NeverScrollableScrollPhysics(),
                 mainAxisSpacing:1 ,
                 crossAxisSpacing: 1,
                 childAspectRatio:1/1.58 ,
                 shrinkWrap:true ,
                    crossAxisCount: 2,
                  children:List.generate(model!.data!.products.length,(index)=>buildGridBuilder(model.data?.products[index],context)
                  ),
                ),
             ),
          ],
        ),
      );

  Widget buildCategoryItem(GategoryData? model) =>  Container(
  width: 100,
  height: 100,
  child: Stack(
  alignment: Alignment.bottomCenter,
  children: [
  Image(image: NetworkImage('${model?.image}'),
  height: 100,
  width: 100,
  fit: BoxFit.cover
  ),
  Container(
  color: Colors.black.withOpacity(0.6),
  width: double.infinity,
  child: Text('${model?.name}',
  textAlign: TextAlign.center,
  maxLines: 1,
  overflow:TextOverflow.ellipsis ,
  style:TextStyle(
  color: Colors.white,

  ) ,
  )
  )
  ],
  ),
  );
  
  Widget buildGridBuilder(ProductModel? model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart ,
          children: [
            Image(
                image:NetworkImage('${model?.image}'),
              width: double.infinity,
              height: 200,

            ),
            if (model?.discount !=0)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white ,

                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${model?.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model?.price.round()} LE',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model?.discount != 0 )
                    Text(
                      '${model?.oldPrice.round()} LE',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough

                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      Shopcupit.get(context).changeFavorites((model?.id)as int);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: Shopcupit.get(context).favorites[model?.id] ?defaultColor :Colors.grey,
                      child: Icon(Icons.favorite_border,
                      color: Colors.white,
                      ),
                    ),

                  )


                ],

              ),
            ],
          ),
        )

      ],
    ),
  );

}
