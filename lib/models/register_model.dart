class registerModel {
  bool? status;
  late String message;
  dataregister? data;

  registerModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? dataregister.fromjson(json['data']) : null;
  }
}

class dataregister {
  late String name;
  late String phone;
  late String email;
  late String token;
  dataregister.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }
}
