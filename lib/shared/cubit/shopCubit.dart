
 import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/endPoint.dart';
import 'package:shop_app/Network/remote/dio_helper.dart';
import 'package:shop_app/model/changeFavoritesModel.dart';
import 'package:shop_app/model/favoritesModel.dart';
import 'package:shop_app/model/gategoriesModel.dart';
import 'package:shop_app/model/homeModel.dart';
import 'package:shop_app/model/searchModel.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../model/loginModel.dart';
import '../../modules/category/category.dart';
import '../../modules/favorites/favorites.dart';
import '../../modules/product/product.dart';
import '../../modules/setting/setting.dart';
import '../component/constans.dart';

class Shopcupit extends Cubit<ShopState>{
  Shopcupit():super(ShopInitState());
  static Shopcupit get(context)=>BlocProvider.of(context);

List Screens=[
  ProductScreen(),
  CategoryScreen(),
  FavoritesScreen(),
  SettingScreen(),
];
int currentIndex=0;

void changeIndex(index){
  currentIndex=index;

  emit(ShopBottomNav());
}

HomeModel? homeModel;

Map<dynamic,dynamic> favorites={};

void getHomeData(){
  emit(ShopingLoadingHome());
  DioHelper.getData(
    url: HOME,
    token:token,
  ).then((value) {

    print(token);
    homeModel=HomeModel.formJson(value.data);
     // print(homeModel?.data?.products[0].image);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites

        });
      });
    emit(ShopingSuccessHome());
  }).catchError((error){
    print('Error ${error.toString()}');
  });
}

GategoryModel? gategoryModel;

void getGategoryData(){
  emit(ShopingLoadingcategories());

  DioHelper.getData(
      url: GATEGORY
  ).then((value){
    gategoryModel=GategoryModel.formJson(value.data);
    //print(gategoryModel?.data?.data[0].image );
    emit(ShopingSuccesscategories());
  });


}
  ChangeFavoritesModel? changeFavoritesModel;

void changeFavorites(int productId){
  favorites[productId]=!favorites[productId];
  emit(ShopingFavorites());

  DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id":productId
      },
    token: token
  ).then((value){
    changeFavoritesModel=ChangeFavoritesModel.formJson(value.data);
   // print(favoritesModel?.message);
    if(changeFavoritesModel?.status==false) {
      favorites[productId] = !favorites[productId];
    }else{
      getFavorites();
    }
emit(ShopingChangeFaavorites(changeFavoritesModel!));
  }).catchError((err){
    favorites[productId]=!favorites[productId];
    print('Errorrrr $err');
  });
}

FavoritesModel? favoritesModel;

void getFavorites(){
  emit(ShopingGetLoadingFavorites());
  DioHelper.getData(
      url: FAVORITES,
    token: token
  ).then((value) {
    favoritesModel=FavoritesModel.fromJson(value.data);
    //print(favoritesModel?.data?.data?[0].product?.name);
    emit(ShopingGetSuccessFavorites());
  }).catchError((err){
    print('Errorrrrr $err');
  }

  );
}

  ShopLoginModel? userModel;

void getUserDAta(){
  emit(ShopingGetLoadingUser());
  DioHelper.getData(
      url: PROFILE,
    token: token
  ).then((value) {
    userModel=ShopLoginModel.fromJson(value.data);
   // print(userModel?.data?.name);
    emit(ShopingGetSuccessUser(userModel!));
  }).catchError((err){
    print('Errorrrrr $err');
  }

  );
}

SearchModel? searchModel;

void searchProduct({
  required String text
}){
emit(ShopSearchLoadingState());
DioHelper.postData(
    url: SEARCH,
    data: {
      'text':text
    }
).then((value) {
  searchModel=SearchModel.fromJson(value.data);
  print(searchModel?.data?.data![0].name);
  emit(ShopSearchSuccessState());
});

}



}

void printFullText(String text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=>print(element.group(0)));
}