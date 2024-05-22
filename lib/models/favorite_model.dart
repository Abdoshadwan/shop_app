class FavoriteModel {
  late bool status;
  late datafavModel data;
  FavoriteModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = datafavModel.fromjson(json['data']);
  }
}

class datafavModel {
  late int currentpage;
  List<dataModel> data = [];
  late String first_page_url;
  
  late int last_page;
  late String last_page_url;
 
  late String path;
  late int per_page;

  late int total;
  datafavModel.fromjson(Map<String, dynamic> json) {
    currentpage = json['current_page'];
    json['data'].forEach((element) {
      data.add(dataModel.fromjson(element));
    });
    first_page_url = json['first_page_url'];

    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
 
    path = json['path'];
    per_page = json['per_page'];
    
    total = json['total'];
  }
}

class dataModel {
  late int id;
  late ProductsModel product;
  dataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductsModel.fromjson(json['product']);
  }
}

class ProductsModel {
  late int id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String image = '';
  late String name;


  
  ProductsModel.fromjson(Map<String, dynamic> jsnpro) {
    id = jsnpro['id'];
    price = jsnpro['price'];
    oldprice = jsnpro['old_price'];
    discount = jsnpro['discount'];
    image = jsnpro['image'];
    name = jsnpro['name'];


  }
}
