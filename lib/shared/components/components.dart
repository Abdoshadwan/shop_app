import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateto(context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
void navigatet_close(context, Widget screen) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => screen), (route) => false);

Widget defaulttextfield({
  required TextEditingController controller,
  required String? Function(String?) validator,
  required TextInputType keyboardType,
  VoidCallback? ontp,
  Function(String)? onSubmit,
  Function(String)? onchange,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool obscure = false,
}) =>
    TextFormField(
      obscureText: obscure,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
        hoverColor: primary_c,
        suffixIcon: GestureDetector(
          onTap: ontp,
          child: Icon(suffix),
        ),
      ),
    );

Widget defaultbutton({required VoidCallback onpress, String? text}) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(100, 30)),
        onPressed: onpress,
        child: Text('${text!.toUpperCase()}'));

void showtost({required String message, required toaststates statuss}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choosetoastcolor(statuss),
        textColor: Colors.white,
        fontSize: 16);

enum toaststates { success, error, warning }

Color choosetoastcolor(toaststates statuss) {
  switch (statuss) {
    case toaststates.success:
      return Colors.green;
    case toaststates.error:
      return Colors.red;
    case toaststates.warning:
      return Colors.yellow;
  }
}

buttonsNav(
        {required VoidCallback press,
        required String text,
        required IconData icona,
        required Color color,
        }) =>
    MaterialButton(
        animationDuration: Duration(milliseconds: 800),
        focusElevation: 50,
        hoverElevation: 20,
        minWidth: 40,
        onPressed: press,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icona,
              size: 30,
              color: color,
            ),
            Text(text)
          ],
        ));

Widget buildlistproduct(model, cubit) => Container(
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
                if (model.discount != 0)
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
      ),
    );
