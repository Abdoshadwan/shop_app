import 'package:dio/dio.dart';

class Dio_Helper {
  static var dio = Dio(BaseOptions(
    baseUrl: 'https://student.valuxapps.com/api/',
    receiveDataWhenStatusError: true,
  ));

  static Future<Response> getfromDB(
      {required String url,
      dynamic query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> PostinDB(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token
    };
    return dio.post(url, queryParameters: query, data: data);
  }
}
