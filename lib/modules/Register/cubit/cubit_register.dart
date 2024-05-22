import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  
RegisterCubit():super(registerInitialsState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  registerModel? model;
  void Register_user({
    required String name,
    required String phone,
    required String email,
    required var password,
    String? image,
  }) {
    emit(registerLoadState());
    Dio_Helper.PostinDB(
            url: register,
            data: {
              'name': name,
              'phone': phone,
              'email': email,
              'password': password,
            },
            token: token)
        .then((value) {
      model = registerModel.fromjson(value.data);
      print(model?.message);
      emit(registerSuccessState(model));
    }).catchError((error) {
      print('error occur register =${error.toString()}');
      emit(registerErrorState());
    });
  }
}
