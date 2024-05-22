import 'package:shop_app/models/cg_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class InitialState extends ShopStates {}

class BottomNavigationchg extends ShopStates {}

class HomeLoadingState extends ShopStates {}

class HomeSuccessState extends ShopStates {
  HomeModel? homemodel;
  HomeSuccessState(this.homemodel);
}

class HomeErrorState extends ShopStates {}

class CategoriesSuccessState extends ShopStates {}

class CategoriesErrorState extends ShopStates {}

class cgfavoriteState extends ShopStates {
  late favoriteModel model;
  cgfavoriteState(this.model);
}

class cgfavoriteerrorState extends ShopStates {}

class iconcgState extends ShopStates {}

class FavoritesSuccessState extends ShopStates {}

class FavoritesErrorState extends ShopStates {}

class FavoritesLoadState extends ShopStates {}

class UserSuccessState extends ShopStates {
  LoginModel? usermodel;
  UserSuccessState(this.usermodel);
}

class UserErrorState extends ShopStates {}

class UserLoadState extends ShopStates {}

