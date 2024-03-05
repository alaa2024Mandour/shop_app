import '../../models/loginModel/loginModel.dart';

abstract class ShopLoginStatus {}

class ShopLoginInitialStatus extends ShopLoginStatus {}

class ShopLoginLoadingStatus extends ShopLoginStatus {}

class ShopLoginSucccessStatus extends ShopLoginStatus {
  final ShopLoginModel loginModel;
  ShopLoginSucccessStatus(this.loginModel);
}

class ShopLoginErorrStatus extends ShopLoginStatus {
  late final String erorr;
  ShopLoginErorrStatus(this.erorr);
}

class ShopLoginChangePassStatus extends ShopLoginStatus {}