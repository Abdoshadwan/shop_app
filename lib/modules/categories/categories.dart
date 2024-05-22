import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_mode.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) => itembuilder(
                ShopCubit.get(context).categorymodel!.data.data[index]),
            separatorBuilder: (context, index) => Divider(
                color: Colors.grey, thickness: 2, indent: 100, endIndent: 100),
            itemCount: ShopCubit.get(context).categorymodel!.data.data.length),
      ),
    );
  }
}

Widget itembuilder(DataInCategories model) {
  return Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          model.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.arrow_forward)
      ],
    ),
  );
}
