import 'package:flutter/material.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/Login/Login.dart';
import 'package:shop_app/modules/OnBoarding/OnBoarding.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/local/cache/cache.dart';
import 'package:shop_app/shared/styles/Themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Cache.Init();
  bool? onboarding = Cache.get_saved(key: 'onBoarding');
  print(onboarding);
  token = Cache.get_saved(key: 'token') ?? 'null';
  print(token);

  Widget? home;
  if (onboarding == null) {
    home = OnBoarding();
  }
  if (onboarding != null) {
    if (token != 'null') {
      home = Home();
    } else {
      home = Login();
    }
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) => ShopCubit()
            ..getHome_data()
            ..getCategory_data()
            ..getfavorite_data()
            ..getuser_data())
    ],
    child: MaterialApp(
      darkTheme: darktheme,
      theme: lighttheme,
      debugShowCheckedModeBanner: false,
      home: home,
    ),
  ));
}

// ignore: must_be_immutable
// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }


