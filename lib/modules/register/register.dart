import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/shopLoginCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../shared/component/component.dart';

class RegisterScreen extends StatelessWidget {
var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();
var passwordController=TextEditingController();

final GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black
                      ),
                    ),
                    Text(
                      'Register Now To Be Browser our Hot offer',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 30,),
                    Form(
                      key: formKey,
                      child: Column(
                          children: [
                            defaultTextFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                label: 'User Name',
                                prefixIcon: Icons.email,
                                kind: 'UserName'
                            ),
                            SizedBox(height: 20,),
                            defaultTextFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'Email',
                                prefixIcon: Icons.email,
                                kind: 'email'
                            ),
                            SizedBox(height: 20,),
                            defaultTextFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                prefixIcon: Icons.lock,
                                kind: 'Password',
                                suffixIcon: ShopLoginCubit.get(context).suffix,
                                showPass: (){
                                  ShopLoginCubit.get(context).changePasswordVisibility();
                                },
                                isPass: ShopLoginCubit.get(context).obscureText
                            ),
                            SizedBox(height: 20,),
                            defaultTextFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                label: 'Phone',
                                prefixIcon: Icons.phone,
                                kind: 'Phone'
                            ),
                            SizedBox(height: 20,),
                            ConditionalBuilder(
                                condition: state is! ShopRegisterLoadingState,
                                builder: (context)=>defaultButton(
                                    text: 'sgin in',
                                    onpressed: (){
                                      if(formKey.currentState!.validate()){
                                        ShopLoginCubit.get(context).registerUser(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text);

                                      }

                                    }), fallback: (BuildContext context) =>Container(),
                            )
                          ]
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
