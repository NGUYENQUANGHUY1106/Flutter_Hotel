import 'dart:convert';
import 'package:book_hotel/Model/CustomerModel.dart';
import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/ProvinceVn.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryIndexUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Controllerhomeuser extends GetxController {
  Repositoryindexuser repositoryindexuser = GetIt.I<Repositoryindexuser>();
  final hotels = <HotelModel>[].obs;
  final isLoading = false.obs;
  final isLoadingSearch = false.obs;
  final provinces = <ProvinceVn>[].obs;
  final customer = Rx<CustomerModel?>(null);
  ProvinceVn? selectProvince;
  final nameHotel = TextEditingController();
  late final SharedPreferences prefs;
  final pathData = 'assets/data/ProvinceData.json';

  var bookingCounts = <String, int>{}.obs;
  var favoriteCount = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    prefs = GetIt.I<SharedPreferences>();
    await getCustomer(); // Lấy thông tin user và gọi fetchCounts
    await getHotels();
    getProvinces();
    isLoading.value = false;
  }

  @override
  void onReady() {
    // Khi màn hình đã sẵn sàng thì tự động refresh lại dữ liệu
    final userId = customer.value?.user?.id;
    if (userId != null) {
      fetchCounts(userId);
    }
    super.onReady();
  }

  Future<void> getHotels() async {
    hotels.clear();
    hotels.value = await repositoryindexuser.getAllHotel();
  }

  void getProvinces() async {
    String jsonString = await rootBundle.loadString(pathData);
    Map<String, dynamic> mapData = jsonDecode(jsonString);
    List<dynamic> listData = mapData['province'];
    provinces.clear();
    provinces.value = listData.map((e) => ProvinceVn.fromMap(e)).toList();
  }

  void seacherHotel() async {
    if (selectProvince == null && nameHotel.text == "") {
      return;
    }
    isLoadingSearch.value = true;
    hotels.clear();
    hotels.value =
        await repositoryindexuser.searchHotel(selectProvince, nameHotel.text);
    isLoadingSearch.value = false;
  }

  Future<void> getCustomer() async {
    int idUser = await getIdUser();
    customer.value = await repositoryindexuser.getCustomer(idUser);

    final userId = customer.value?.user?.id;
    if (userId != null) {
      await fetchCounts(userId);
    }
  }

  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }

  Future<void> fetchCounts(int userId) async {
    try {
      final dio = Dio();

      final bookingRes = await dio.get(
        'http://192.168.137.1:8080/mvc_10/book_hotel/booking-counts/$userId',
      );
      bookingCounts.value = Map<String, int>.from(bookingRes.data);

      final favRes = await dio.get(
        'http://192.168.137.1:8080/mvc_10/api/favorite/count/$userId',
      );
      favoriteCount.value = favRes.data;
    } catch (e) {
      print("❌ Lỗi khi fetchCounts: $e");
    }
  }
}
