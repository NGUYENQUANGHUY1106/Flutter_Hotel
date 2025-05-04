import 'package:dio/dio.dart';

class UtilMessageApi {
 static String? getMessage(DioException e) {
  final data = e.response?.data;
  if (data is Map && data.containsKey("error")) {
    return data["error"].toString();
  }
  return data.toString(); 
}

}
