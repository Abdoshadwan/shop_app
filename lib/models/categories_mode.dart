class CategoriesModel {
  late bool status;
  late Data_Categories data;

  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data_Categories.fromjson(json['data']);
  }
}

class Data_Categories {
  late int current_page;
   List<DataInCategories> data =[];

  Data_Categories.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];

    json['data'].forEach((element) {
      data.add(DataInCategories.fromjson(element));
      
    });
  }
}

class DataInCategories {
  late int id;
  late String name;
  late String image;
  DataInCategories.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
