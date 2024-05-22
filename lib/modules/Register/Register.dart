import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/modules/Register/cubit/cubit_register.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/local/cache/cache.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is registerSuccessState) {
            if (state.model!.status!) {
              Cache.putdata(key: 'token', value: state.model?.data!.token)
                  .then((value) {
                token = state.model!.data!.token;
                navigatet_close(context, Home());
              });
            } else {
              showtost(
                  message: state.model!.message, statuss: toaststates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Register new person',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      defaulttextfield(
                          controller: namecontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'name must not be null';
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
                          controller: phonecontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'phone must not be null';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),
                      defaulttextfield(
                          controller: emailcontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'email must not be null';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Addreess',
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaulttextfield(
                          controller: passwordcontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password must not be null';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          onSubmit: (value) {
                            if (formkey.currentState!.validate()) {
                              RegisterCubit.get(context).Register_user(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
                          prefix: Icons.password),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! registerLoadState,
                        builder: (context) => defaultbutton(
                            onpress: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).Register_user(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            text: 'register'),
                        fallback: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
