class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products= [];

  HomeDataModel.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  late int id;
  late String image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price,oldPrice,discount;
  late String image,name;
  late bool inFavorites,inCart;

  ProductsModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      inFavorites = json['in_favorites'];
      inCart = json['in_cart'];
  }
}