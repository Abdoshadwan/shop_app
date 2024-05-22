import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Login/cubit/states.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  LoginModel? loginmodel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    Dio_Helper.PostinDB(url: Login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginmodel = LoginModel.fromjson(value.data);
      // print(loginmodel!.data!.email);
      // print(loginmodel!.message);
      emit(LoginSuccessState(loginmodel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print('error occur post ${error.toString()}');
    });
  }

  IconData suffix = Icons.visibility;
  bool issecure = true;
  void changesuffix() {
    issecure = !issecure;

    suffix = issecure ? Icons.visibility : Icons.visibility_off_outlined;

    emit(changesuffixstate());
  }
}
