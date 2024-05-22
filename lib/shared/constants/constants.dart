import 'package:shop_app/modules/Login/Login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/local/cache/cache.dart';

void signout(context) {
  Cache.removedata(key: 'token').then((value) {
    navigatet_close(context, Login());
  });
}

void printfulltext(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String token = '';
