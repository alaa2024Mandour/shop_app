import '../../ShopApp/login/shop_loginScreen.dart';
import '../network/local/cachHelper.dart';
import 'components.dart';

void signOut (context) {
    CachHelper.removeData(key: 'token').then((value) {
      navegateAndFinish(context, ShopLoginScreen());
    });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = ' ' ;