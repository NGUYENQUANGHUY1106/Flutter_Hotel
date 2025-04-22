import 'dart:io';

import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/core/util/util_message_api.dart';
import 'package:book_hotel/data/domain/EndpointHotel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repositoryhotelsignup {
  final Dio dio;final SharedPreferences sharedPreferences;
  Repositoryhotelsignup({required this.dio, required this.sharedPreferences});

  Future<void> signUp(
      {required HotelModel hotel,
      required Function() success,
      required Function(String? e) error}) async {
    try {
      print(hotel.toJson());
      Response response =
          await dio.post(Endpointhotel.signUp, data: hotel.toJson());
      print(response);
      if (response.statusCode == 200) {
        success();
      }
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 400) {
        String? messageError = UtilMessageApi.getMessage(e);
        error(messageError);
      }
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    try {
      print(fileName);
      removeData();
      final response = await dio.post(
        Endpointhotel.uploadImg,
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );
      print(' Upload success: ${response.data}');
      if (response.statusCode == 200) {
        return response.data["img"];
      }
    } catch (e) {
      return "Thông Tin Đăng Nhập Không Đúng";
    }
  }
    void removeData() {
    sharedPreferences.remove(UtilConst.token);
    sharedPreferences.remove(UtilConst.refreshToken);
  }
}
