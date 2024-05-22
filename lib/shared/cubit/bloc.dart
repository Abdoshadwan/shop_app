import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_mode.dart';
import 'package:shop_app/models/cg_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/end_points.dart';
// import 'package:shop_app/shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

//change between screens
  int currentindex = 0;
  List<Widget> shop_screens = [
    Products(),
    Categories(),
    Favorites(),
    Settings()
  ];
  void change_screens(int index) {
    currentindex = index;
    emit(BottomNavigationchg());
  }

  //******************************************************************************************** */
  //Home or products

  HomeModel? homemodel;
  Map<int, bool> favorites = {};
  void getHome_data() {
    emit(HomeLoadingState());
    Dio_Helper.getfromDB(url: Home, token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      // print(homemodel?.data?.banners![0].image.toString());
      homemodel?.data?.products?.forEach((element) {
        favorites.addAll({element.id: element.infavorite});
      });
      print(favorites.toString());
      emit(HomeSuccessState(homemodel));
    }).catchError((error) {
      emit(HomeErrorState());
      print('${error.toString()}');
    });
  }

  //********************************************************************************************* */
  //categores get
  CategoriesModel? categorymodel;
  void getCategory_data() {
    Dio_Helper.getfromDB(url: categories, token: token).then((value) {
      categorymodel = CategoriesModel.fromjson(value.data);

      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
      print('${error.toString()}');
    });
  }

  //********************************************************************************************** */
  //is favorite button
  favoriteModel? cgfavorite;

  void changefavorite(int product_id) {
    favorites[product_id] = !favorites[product_id]!;
    emit(iconcgState());
    Dio_Helper.PostinDB(
            url: favorite, data: {'product_id': product_id}, token: token)
        .then(
      (value) {
        cgfavorite = favoriteModel.fromjson(value.data);
        print(value.data);
        if (!cgfavorite!.status) {
          favorites[product_id] = !favorites[product_id]!;
        } else {
          getfavorite_data();
        }
        emit(cgfavoriteState(cgfavorite!));
      },
    ).catchError((error) {
      favorites[product_id] = !favorites[product_id]!;
      print('error occur during post favorites${error.toString()}');
      emit(cgfavoriteerrorState());
    });
  }

  //********************************************************************************************* */
  //favorites get
  FavoriteModel? favoritemodel;
  void getfavorite_data() {
    emit(FavoritesLoadState());
    Dio_Helper.getfromDB(url: favorite, token: token).then((value) {
      favoritemodel = FavoriteModel.fromjson(value.data);
      print(favoritemodel!.data.toString());

      emit(FavoritesSuccessState());
    }).catchError((error) {
      emit(FavoritesErrorState());
      print('${error.toString()}');
    });
  }

  //********************************************************************************************* */
  //user profile get
  LoginModel? usermodel;
  void getuser_data() {
    emit(UserLoadState());
    Dio_Helper.getfromDB(url: profile, token: token).then((value) {
      usermodel = LoginModel.fromjson(value.data);
      print(usermodel!.data?.name.toString());

      emit(UserSuccessState(usermodel));
    }).catchError((error) {
      emit(UserErrorState());
      print('${error.toString()}');
    });
  }

  
  
}
