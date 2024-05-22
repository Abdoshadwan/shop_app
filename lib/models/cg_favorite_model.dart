class favoriteModel {
  late bool status;
  late String message;
  favoriteModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
