import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  Settings({super.key});
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).usermodel;
          namecontroller.text = model!.data!.name;
          emailcontroller.text = model.data!.email;
          phonecontroller.text = model.data!.phone;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).usermodel != null,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defaulttextfield(
                        controller: namecontroller,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'name mustn\'t empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    defaulttextfield(
                        controller: emailcontroller,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email mustn\'t empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
                    ),
                    defaulttextfield(
                        controller: phonecontroller,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone mustn\'t empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        label: 'Phone',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 200,
                    ),
                    defaultbutton(
                        onpress: () {
                          signout(context);
                        },
                        text: 'Logout')
                  ],
                ),
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
