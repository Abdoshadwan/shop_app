import 'package:flutter/material.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      navigateto(context, Search());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ))
              ],
              title: Text(
                'shop',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: cubit.shop_screens[cubit.currentindex],
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: FloatingActionButton(
                splashColor: Colors.blue,
                onPressed: () {
                  cubit.change_screens(0);
                },
                child: Icon(Icons.home),
                backgroundColor:
                    cubit.currentindex != 0 ? Colors.grey : Colors.blue,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 60,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  buttonsNav(
                      icona: Icons.category,
                      color:
                          cubit.currentindex != 1 ? Colors.grey : Colors.blue,
                      press: () {
                        cubit.change_screens(1);
                      },
                      text: 'Categories'),
                  SizedBox(
                    width: 27,
                  ),
                  buttonsNav(
                      icona: Icons.favorite,
                      color:
                          cubit.currentindex != 2 ? Colors.grey : Colors.blue,
                      press: () {
                        cubit.change_screens(2);
                      },
                      text: 'Favorites'),
                  SizedBox(
                    width: 27,
                  ),
                  buttonsNav(
                      icona: Icons.settings,
                      color:
                          cubit.currentindex != 3 ? Colors.grey : Colors.blue,
                      press: () {
                        cubit.change_screens(3);
                      },
                      text: 'Settings'),
                  SizedBox(
                    width: 27,
                  ),
                ]),
              ),
            ));
      },
    );
  }
}
