import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../Network/local/shared_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() :super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode appDark = ThemeMode.dark;

  bool mode = false;

  void changeMode({bool? isDark}) {
    if (isDark != null) {
      mode = isDark;
      emit(AppModeState());
    }
    else{
      mode=!mode;
      CacheHelper.saveData(key: 'mode', value: mode).then((value){
        emit(AppModeState());
      });
    }
  }


}
