import 'package:book_hotel/Model/FavoriteHotelModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:book_hotel/core/util/UtilConst.dart';

class FavoriteHotelController extends GetxController {
  var favorites = <FavoriteHotelModel>[].obs;
  final dio = Dio();

  Future<void> fetchFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(UtilConst.idUser);
    if (userId == null) return;

    try {
      final res = await dio.get('http://192.168.1.202:8080/mvc_10/api/favorite/$userId');
      print(" Gọi đến: http://192.168.1.202:8080/mvc_10/api/favorite/$userId");

      favorites.value =
          (res.data as List).map((e) => FavoriteHotelModel.fromMap(e)).toList();
    } catch (e) {
      print(' Lỗi fetchFavorites: $e');
    }
  }
}
