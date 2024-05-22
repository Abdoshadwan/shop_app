class HomeModel {
  bool? status;
  DataModel? data;

  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromjson(json['data']);
  }
}

class DataModel {
  List<BannersModel>? banners = [];
  List<ProductsModel>? products = [];

  DataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners?.add(BannersModel.fromjson(element));
    });

    json['products'].forEach((element) {
      products!.add(ProductsModel.fromjson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  String? category;
  String? product;

  BannersModel.fromjson(Map<String, dynamic> jsnbanner) {
    id = jsnbanner['id'];
    image = jsnbanner['image'];
  }
}

class ProductsModel {
  late int id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String image = '';
  late String name;

  late bool infavorite;
  bool? incart;
  ProductsModel.fromjson(Map<String, dynamic> jsnpro) {
    id = jsnpro['id'];
    price = jsnpro['price'];
    oldprice = jsnpro['old_price'];
    discount = jsnpro['discount'];
    image = jsnpro['image'];
    name = jsnpro['name'];
    infavorite = jsnpro['in_favorites'];
    incart = jsnpro['in_cart'];
  }
}
