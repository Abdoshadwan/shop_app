import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit_search.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'search',
                style: TextStyle(color: Colors.black),
              )
              ),
          body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  defaulttextfield(
                      controller: searchcontroller,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to serach';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).Search(text);
                      },
                      keyboardType: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchloadingState) LinearProgressIndicator(),
                  if (state is SearchsuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildsearch(
                              SearchCubit.get(context).model?.data.data[index],
                              SearchCubit.get(context),
                              context),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 1,
                              ),
                          itemCount: SearchCubit.get(context)
                                      .model
                                      ?.data
                                      .data
                                      .length ==
                                  null
                              ? 0
                              : SearchCubit.get(context)
                                  .model!
                                  .data
                                  .data
                                  .length
                                  ),
                    ),
                ]),
              )),
        ),
      ),
    );
  }
}

Widget buildsearch(model, cubit, context, {bool isoldprice = false}) =>
    Container(
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
                  image: NetworkImage(model.image),
                ),
                if (model.discount != 0 && isoldprice)
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
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 3,
                  ),
                  Spacer(),
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
                      if (model.discount != 0 && isoldprice)
                        Text(
                          model.oldprice.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
