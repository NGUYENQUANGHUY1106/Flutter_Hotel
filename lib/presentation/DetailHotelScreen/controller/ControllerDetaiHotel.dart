import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryDetailHotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerDetaiHotel extends GetxController {
  Repositorydetailhotel repositorydetailhotel =
      GetIt.I<Repositorydetailhotel>();

  final HotelModel hotel = Get.arguments as HotelModel;
  final totalPrice = 0.obs;

  final startDate = TextEditingController();
  final endDate = TextEditingController();

  int count = 0;
  final format = DateFormat('dd/MM/yyyy');

  late final SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    prefs = GetIt.I<SharedPreferences>();

    // Ví dụ: lấy dữ liệu từ prefs
    String? token = prefs.getString('token');
    print('Token: $token');
  }

  void selectDate(BuildContext context, TextEditingController value) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      value.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  void onChangeRoom(int count, BuildContext context) {
    if (startDate.text == "" || endDate.text == "") {
      Dialogcustom.show(context, "Điền thông tin ngày");
    }
    this.count = count;
    int totalDat = getTotalDays(startDate.text, endDate.text);
    totalPrice.value = totalDat * hotel.price! * count;
  }

  int getTotalDays(String start, String end) {
    final startDate = format.parse(start);
    final endDate = format.parse(end);

    return endDate.difference(startDate).inDays;
  }

  void bookHotel(BuildContext context) async {
    int idUser = await getIdUser();
    final data = RequestBookHotelModel(
        idUser: idUser,
        idHotel: hotel.id!,
        totalPrice: totalPrice.value,
        countRoom: count,
        bookStart: format.parse(startDate.text),
        bookEnd: format.parse(endDate.text));
    await repositorydetailhotel.bookHotel(
      data: data,
      success: () {
        Dialogcustom.show(
          context,
          "Đặt phòng thành công",
        );
      },
      e: () => Dialogcustom.show(context, "sdsd", isSuccess: false),
    );
  }

  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }
}
