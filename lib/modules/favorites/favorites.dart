// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! FavoritesLoadState,
          builder: (context) => cubit.favoritemodel?.data.data.length == 0
              ? Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => buildfavorite(
                      cubit.favoritemodel!.data.data[index], cubit),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 1,
                      ),
                  itemCount: cubit.favoritemodel?.data.data.length == null
                      ? 0
                      : cubit.favoritemodel!.data.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildfavorite(dataModel model, cubit) => Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      child: Card(
        elevation: 10,
        shadowColor: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  height: 120,
                  width: 120,
                  image: NetworkImage(model.product.image),
                ),
                if (model.product.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'Disacount',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 3,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: primary_c),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          model.product.oldprice.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            cubit.changefavorite(model.product.id);
                          },
                          icon: cubit.favorites[model.product.id]!
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
