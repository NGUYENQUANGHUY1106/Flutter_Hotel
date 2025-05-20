
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
  var hotelDetail = Rxn<HotelModel>();
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
    fetchHotelDetail(hotel.id!);
  }

  Future<void> fetchHotelDetail(int idHotel) async {
    try {
      final response = await dio.get("http://192.168.88.53:8080/hotel/$idHotel");
      hotelDetail.value = HotelModel.fromMap(response.data);
      hotel.room = hotelDetail.value?.room;
      hotel.price = hotelDetail.value?.price;
      hotel.username = hotelDetail.value?.username;
      hotel.address = hotelDetail.value?.address;
      hotel.img = hotelDetail.value?.img;
    } catch (e) {
      print('Loi fetchHotelDetail: $e');
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
      Dialogcustom.show(context, "Dien thong tin ngay", isSuccess: false);
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

  // ✅ Kiểm tra định dạng ngày
  DateTime? start;
  DateTime? end;

  try {
    start = format.parse(startDate.text);
    end = format.parse(endDate.text);
  } catch (e) {
    Dialogcustom.show(context, "Vui lòng chọn đúng định dạng ngày", isSuccess: false);
    return;
  }

  //  Kiểm tra ngày nhận phòng >= hôm nay
  DateTime today = DateTime.now();
  DateTime todayDateOnly = DateTime(today.year, today.month, today.day);
  if (start.isBefore(todayDateOnly)) {
    Dialogcustom.show(context, "Ngày Nhận Không Chính Xác ", isSuccess: false);
    return;
  }

  //  Kiểm tra ngày trả phòng sau ngày nhận phòng
  if (!end.isAfter(start)) {
    Dialogcustom.show(context, "Ngày Trả Phòng Không Chính Xác", isSuccess: false);
    return;
  }

  //  Kiểm tra số lượng phòng
  if (count <= 0) {
    Dialogcustom.show(context, "Số lượng phòng phải lớn hơn 0", isSuccess: false);
    return;
  }

  //  Tiếp tục đặt phòng nếu hợp lệ
  final data = RequestBookHotelModel(
    idUser: idUser,
    idHotel: hotel.id!,
    totalPrice: totalPrice.value,
    countRoom: count,
    bookStart: start,
    bookEnd: end,
  );

  await repositorydetailhotel.bookHotel(
    data: data,
    success: () {
      Dialogcustom.show(context, "Đặt phòng thành công");
    },
    e: () {
      Dialogcustom.show(context, "Đặt phòng thất bại", isSuccess: false);
    },
  );
}


  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }

  Future<void> toggleFavoriteHotel() async {
    try {
      final userId = await getIdUser();
      final hotelId = hotel.id;
      await dio.post("http://192.168.88.53:8080/mvc_10/api/favorite/toggle/$userId/$hotelId");
      print("\u{1F49C} Da yeu thich khach san!");
    } catch (e) {
      print(" Loi khi yeu thich khach san: $e");
    }
  }
}