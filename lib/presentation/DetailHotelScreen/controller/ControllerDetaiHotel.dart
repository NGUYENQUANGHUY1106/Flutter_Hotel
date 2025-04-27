import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryDetailHotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ControllerDetaiHotel extends GetxController {
  final Repositorydetailhotel repositorydetailhotel = GetIt.I<Repositorydetailhotel>();
  final HotelModel hotel = Get.arguments as HotelModel;

  final dio = Dio();
  var hotelDetail = Rxn<HotelModel>(); // ✅ Đây sẽ chứa dữ liệu mới fetch
  final totalPrice = 0.obs;
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final format = DateFormat('dd/MM/yyyy');
  late final SharedPreferences prefs;

  int count = 0;

  @override
  void onInit() {
    super.onInit();
    prefs = GetIt.I<SharedPreferences>();
    print('Thông tin hotel trước khi fetch: ${hotel.toJson()}');
    fetchHotelDetail(hotel.id!); // phải là hotel.id
    print('Token: ${prefs.getString('token')}');
  }

Future<void> fetchHotelDetail(int idHotel) async {
  try {
    // print('Fetching hotel id: $idHotel');  
    // print('Fetching URL: http://192.168.88.53:8080/hotel/$idHotel');
   final response = await dio.get("http://192.168.88.53:8080/hotel/$idHotel");

    print('Response data: ${response.data}'); // Thêm dòng này
    hotelDetail.value = HotelModel.fromMap(response.data);
    // print('Hotel room: ${hotelDetail.value?.room}'); // In ra số phòng xem
  } catch (e) {
    // print('Lỗi fetchHotelDetail: $e');
  }
}




  void selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.text = format.format(pickedDate);
    }
  }

  void onChangeRoom(int count, BuildContext context) {
    if (startDate.text.isEmpty || endDate.text.isEmpty) {
      Dialogcustom.show(context, "Điền thông tin ngày", isSuccess: false);
      return;
    }
    this.count = count;
    int totalDays = getTotalDays(startDate.text, endDate.text);

    int price = hotelDetail.value?.price ?? hotel.price ?? 0;
    totalPrice.value = totalDays * price * count;
  }

  int getTotalDays(String start, String end) {
    final startParsed = format.parse(start);
    final endParsed = format.parse(end);
    return endParsed.difference(startParsed).inDays;
  }

  void bookHotel(BuildContext context) async {
    int idUser = await getIdUser();
    final data = RequestBookHotelModel(
      idUser: idUser,
      idHotel: hotel.id!,
      totalPrice: totalPrice.value,
      countRoom: count,
      bookStart: format.parse(startDate.text),
      bookEnd: format.parse(endDate.text),
    );
    await repositorydetailhotel.bookHotel(
      data: data,
      success: () {
        Dialogcustom.show(context, "Đặt phòng thành công");
      },
      e: () => Dialogcustom.show(context, "Đặt phòng thất bại", isSuccess: false),
    );
  }

  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }
}
