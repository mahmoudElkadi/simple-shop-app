import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/endPoint.dart';
import 'package:shop_app/Network/remote/dio_helper.dart';
import 'package:shop_app/model/loginModel.dart';
import 'package:shop_app/shared/component/constans.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../model/registerModel.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit():super(ShopLoginInitState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  
  void userLogin({
  required String email,
    required String password
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {

          'email':email,
          'password':password,

        }
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      // print(loginModel?.status);
      // print(loginModel?.message);
      // print(loginModel?.data?.name);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print('error ${error.toString()}');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  ShopRegisterModel? registerModel;

  void registerUser({
  required String name,
  required String email,
  required String phone,
  required String password,

}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
          'password':password
        }).then((value) {
          registerModel=ShopRegisterModel.fromJson(value.data);
          print(registerModel?.message);
          print(registerModel?.data?.id);

          emit(ShopRegisterSuccessState());

    });
  }

  ShopRegisterModel? updateProfileModel;

  void updateProfile({
  required String name,
  required String phone,
  required String email,
}){
    emit(ShopUpdateLoadingState());
    DioHelper.putData(
        url: UPDATEPROFILE,
        token: token,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        }
    ).then((value) {
      updateProfileModel=ShopRegisterModel.fromJson(value.data);
      print(updateProfileModel?.message);
      emit(ShopUpdateSuccessState());
    });
  }



  IconData suffix=Icons.remove_red_eye;
  bool obscureText=true;

  void changePasswordVisibility(){
    obscureText=!obscureText;

    suffix=obscureText? Icons.remove_red_eye: Icons.visibility_off;

    emit(ShopShowPasswordState());
  }




}