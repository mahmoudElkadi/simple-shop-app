import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Network/local/shared_helper.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constans.dart';
import 'package:shop_app/shared/cubit/shopLoginCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../layout/shopApp.dart';
import '../../shared/cubit/shopCubit.dart';

class LoginScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
   var emailController=TextEditingController();
   var passwordController=TextEditingController();
    late final GlobalKey<FormState> formKey =GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status != null && state.loginModel.status ==true)
            {
              print(state.loginModel.data?.token);
              print('aaaa${state.loginModel.message}');

              CacheHelper.saveData(key: 'token', value: '${state.loginModel.data?.token}').then((value){
                token=state.loginModel.data!.token!;
                navigateAndFinish(context, ShopScreen());
              });

              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStatus.SUCCESS,
              );

            }else{

              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStatus.ERROR,
              );
              print('aaaa${state.loginModel.message}');
            }
          }
        },
        builder: (BuildContext context, state) {


          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login Now To Browser Our Hot offer',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormField(
                                controller: emailController,
                                type: TextInputType.visiblePassword,
                                label: 'Email',
                                prefixIcon: Icons.email,
                                kind: 'email'
                            ),
                            SizedBox(height: 20,),
                            defaultTextFormField(
                                controller: passwordController,
                                type: TextInputType.text,
                                label: 'Password',
                                prefixIcon: Icons.lock,
                                kind: 'Password',
                                suffixIcon: ShopLoginCubit.get(context).suffix,
                              showPass: (){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              isPass:ShopLoginCubit.get(context).obscureText,
                              onSubmit:(value){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context)=> defaultButton(text: 'login', onpressed: (){
                                if(formKey.currentState!.validate()) {

                                  ShopLoginCubit.get(context).userLogin(
                                      email: '${emailController.text}',
                                      password: '${passwordController.text}');
                                  BlocProvider(create: (context)=>Shopcupit()..getGategoryData()..getHomeData()..getFavorites()..getUserDAta());

                              }
                              }
                              ),


                              fallback: (context)=> Center(child: CircularProgressIndicator(),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?'),
                                defaultTextButton(function: (){
                                  navigateTo(context, RegisterScreen());
                                },
                                    text: 'Register Now')

                              ],
                            )
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}



