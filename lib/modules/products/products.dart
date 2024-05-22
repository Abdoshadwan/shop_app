import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_mode.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is cgfavoriteState) {
          if (!state.model.status) {
            showtost(message: state.model.message, statuss: toaststates.error); 
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homemodel != null && cubit.categorymodel != null,
            builder: (context) {
              return Productbuilder(
                  cubit.homemodel, cubit.categorymodel, cubit);
            },
            fallback: (context) {
              return Center(child: CircularProgressIndicator());
            });
      },
    );
  }

  Widget Productbuilder(
      HomeModel? model, CategoriesModel? categorymodel, ShopCubit cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners!.map((banner) {
                return Image(
                  image: NetworkImage('${banner.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildcategoryitem(categorymodel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: categorymodel!.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                    model!.data!.products!.length,
                    (index) =>
                        buildproduct(model.data!.products![index], cubit))),
          )
        ],
      ),
    );
  }
}

Widget buildcategoryitem(DataInCategories categorymodel) => Container(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(categorymodel.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: double.infinity,
              color: Colors.black.withOpacity(.8),
              child: Text(
                categorymodel.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
              )),
        ],
      ),
    );

Widget buildproduct(ProductsModel? model, ShopCubit cubit) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model!.image,
              ),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: primary_c),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      model.oldprice.toString(),
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
                        cubit.changefavorite(model.id);
                      },
                      icon: cubit.favorites[model.id]!
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
  );
}
