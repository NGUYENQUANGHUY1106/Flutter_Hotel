import 'dart:ffi';

import 'package:book_hotel/Model/CustomerModel.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/domain/EndpointCustomer.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repositorysignup {
  final Dio dio;
    final SharedPreferences sharedPreferences;


  Repositorysignup({required this.dio, required this.sharedPreferences});

  Future<void> signUp(
      {required CustomerModel data,
      required Function() success,
      required Function(String? e) error}) async {
    print(data.toJson());
    try {
      removeData();
      Response response =
          await dio.post(Endpointcustomer.signUp, data: data.toJson());
      if (response.statusCode == 200) {
        success();
      }
    } on DioException catch (e) {
      error("loi");
    }
  }
  
  void removeData() {
    sharedPreferences.remove(UtilConst.token);
    sharedPreferences.remove(UtilConst.refreshToken);
  }
}
