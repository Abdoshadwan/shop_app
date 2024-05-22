
class LoginModel {
  bool? status;
  String ?message;
  UserDataModel? data;

  LoginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.get(json['data']) : null;
  }
}

class UserDataModel {
  int? id;
  String name='';
  String email='';
  late String phone;
  String? image;
  int? points=null??0;
  int? credit=null??0;
  String? token;

  UserDataModel.get(Map<String, dynamic> jsn) {
    id = jsn['id'];
    name = jsn['name'];
    email = jsn['email'];
    phone = jsn['phone'];
    image = jsn['image'];
    points = jsn['points'];
    credit = jsn['credit'];
    token = jsn['token'];
  }
}
