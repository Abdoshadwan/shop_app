import 'package:shop_app/models/register_model.dart';

abstract class RegisterStates {}

class registerInitialsState extends RegisterStates {}

class registerSuccessState extends RegisterStates {
  registerModel? model;
  registerSuccessState(this.model);
}

class registerErrorState extends RegisterStates {}

class registerLoadState extends RegisterStates {}
