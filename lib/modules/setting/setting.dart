import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constans.dart';
import 'package:shop_app/shared/cubit/shopCubit.dart';
import 'package:shop_app/shared/cubit/shopLoginCubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

class SettingScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var PhoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcupit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
var model=Shopcupit.get(context).userModel;
        nameController.text=model!.data!.name!;
        emailController.text=model!.data!.email!;
        PhoneController.text=model!.data!.phone!;
        return ConditionalBuilder(condition: Shopcupit.get(context).userModel !=null,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'User Name',
                        prefixIcon: Icons.person,
                        kind: 'Name'),
                    SizedBox(height: 20,),
                    defaultTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        prefixIcon: Icons.email,
                        kind: 'Email'),
                    SizedBox(height: 20,),
                    defaultTextFormField(
                        controller: PhoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        prefixIcon: Icons.phone,
                        kind: 'Phone'),
                    SizedBox(height: 20,),
                    defaultButton( text: 'update', onpressed:(){
                      ShopLoginCubit.get(context).updateProfile(
                        email:emailController.text,
                        name: nameController.text,
                        phone: PhoneController.text
                      );
                    }),
                    SizedBox(height: 20,),
                    defaultButton( text: 'LOGout', onpressed:(){
                      logOut(context);
                    })

                  ]),
            ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
