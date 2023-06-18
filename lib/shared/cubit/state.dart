import 'package:shop_app/model/changeFavoritesModel.dart';
import 'package:shop_app/model/loginModel.dart';

abstract class ShopLoginState{}

class ShopLoginInitState extends ShopLoginState{}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopLoginSuccessState extends ShopLoginState{
  late final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginState{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopShowPasswordState extends ShopLoginState{}

class ShopRegisterLoadingState extends ShopLoginState{}
class ShopRegisterSuccessState extends ShopLoginState{}

class ShopUpdateLoadingState extends ShopLoginState{}
class ShopUpdateSuccessState extends ShopLoginState{}




///////////////////////////////////////////////////////////////////////


abstract class ShopState{}

class ShopInitState extends ShopState{}

class ShopBottomNav extends ShopState{}
class ShopingLoadingHome extends ShopState{}
class ShopingSuccessHome extends ShopState{}

class ShopingLoadingcategories extends ShopState{}
class ShopingSuccesscategories extends ShopState{}

class ShopingChangeFaavorites extends ShopState{
  late final ChangeFavoritesModel favoritesModel;
  ShopingChangeFaavorites(this.favoritesModel);
}
class ShopingFavorites extends ShopState{}

class ShopingGetSuccessFavorites extends ShopState{}
class ShopingGetLoadingFavorites extends ShopState{}

class ShopingGetSuccessUser extends ShopState{
  final ShopLoginModel loginModel;
  ShopingGetSuccessUser(this.loginModel);
}
class ShopingGetLoadingUser extends ShopState{}

class ShopSearchLoadingState extends ShopState{}
class ShopSearchSuccessState extends ShopState{}


///////////////////////////////////////////////////////////////////////
abstract class AppState{}

class AppInitState extends AppState{}
class AppModeState extends AppState{}
