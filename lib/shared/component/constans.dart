import 'package:shop_app/Network/local/shared_helper.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/component/component.dart';

dynamic token='';


void logOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
}