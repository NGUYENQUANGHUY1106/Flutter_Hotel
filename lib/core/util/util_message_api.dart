import 'package:dio/dio.dart';

class UtilMessageApi {
  static String? getMessage(DioException e) {
    return e.response?.data["error"];
  }
}
