import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/RateModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/Model/RequestRateModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/data/repository/RepositoryUserDetailBooked.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class Controllerdetailbooked extends GetxController {
  Repositoryuserdetailbooked repositoryuserdetailbooked =
      GetIt.I<Repositoryuserdetailbooked>();

  final bookedHotel = (Get.arguments as BookHotelModel).obs;
  final format = DateFormat('dd/MM/yyyy');
  final rates = <Ratemodel>[].obs;
   final comment = TextEditingController();
  final count = TextEditingController();
  final isLoading = false.obs;
  final isRateStar = false.obs;
   final isLoadingRating = false.obs;
   final dio = Dio(); // thêm dòng này vào


  int c = 0;
  double rateStar = 0;

  final totalMoney = 0.obs;

  @override
  void onInit() {
    startDate.text = format.format(bookedHotel.value.bookStart!);
    endDate.text = format.format(bookedHotel.value.bookEnd!);
    count.text = bookedHotel.value.countRoom!.toString();
    totalMoney.value = bookedHotel.value.totalPrice!;
    super.onInit();
  }

  void onChangeRoom(int count, BuildContext context) {
    if (startDate.text == "" || endDate.text == "") {
      Dialogcustom.show(context, "Điền thông tin ngày");
    }
    this.c = count;
    int totalDat = getTotalDays(startDate.text, endDate.text);
    totalMoney.value = totalDat * bookedHotel.value.hotel!.price! * count;
  }

  int getTotalDays(String start, String end) {
    final startDate = format.parse(start);
    final endDate = format.parse(end);

    return endDate.difference(startDate).inDays;
  }

  final startDate = TextEditingController();
  final endDate = TextEditingController();
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

  void clickCancell(BuildContext context) async {
    isLoading.value = true;
    await repositoryuserdetailbooked.updateStatusBooked(
      bookedHotel.value.id!,
      Enumstatusbook.CANCELLED.name,
      success: (data) => bookedHotel.value = data,
      e: () => Dialogcustom.show(context, "loi huy"),
    );
    isLoading.value = false;
  }

  void clickUpdateBookedHotel(BuildContext context) async {
    isLoading.value = true;
    final dataUpdate = RequestBookHotelModel(
        id: bookedHotel.value.id,
        totalPrice: totalMoney.value,
        countRoom: c,
        bookStart: format.parse(startDate.text),
        bookEnd: format.parse(endDate.text));
    await repositoryuserdetailbooked.updateBookedHotel(
      success: (data) => bookedHotel.value = data,
      data: dataUpdate,
      e: () => Dialogcustom.show(context, "cap nhat loi", isSuccess: false),
    );
    isLoading.value = false;
  }

  void clickReturnRoom(BuildContext context) async {
  try {
    final idBookHotel = bookedHotel.value.id!;
    final response = await dio.put(
      "http://192.168.88.53:8080/book_hotel/checkout/$idBookHotel",
    );

    if (response.statusCode == 200) {
      Dialogcustom.show(context, "Trả phòng thành công");
      // Sau khi trả phòng, load lại dữ liệu booking
      await getDetailBooked(); 
    } else {
      Dialogcustom.show(context, "Trả phòng thất bại", isSuccess: false);
    }
  } catch (e) {
    Dialogcustom.show(context, "Có lỗi xảy ra", isSuccess: false);
  }
}

Future<void> getDetailBooked() async {
  try {
    final idBookHotel = bookedHotel.value.id!;
    final response = await dio.get("http://192.168.88.53:8080/book_hotel/$idBookHotel");
    if (response.statusCode == 200) {
      bookedHotel.value = BookHotelModel.fromMap(response.data);
    }
  } catch (e) {
    print("Lỗi getDetailBooked: $e");
  }
}


  void getAllRate(BuildContext context) async {
     isLoadingRating.value = true;
     rates.clear();
     await repositoryuserdetailbooked.getAllRate(
       success: (rates1) => rates.value = rates1,
       idHotel: bookedHotel.value.hotel!.id!,
       e: () => Dialogcustom.show(context, "loi"),
     );
     isLoadingRating.value = false;
   }
 
   void clickAddRate(BuildContext context) async {
     isLoadingRating.value = true;
     final requestAddRate = Requestaddrate(
         idHotel: bookedHotel.value.hotel!.id!,
         rateStar: rateStar,
         comment: comment.text);
     await repositoryuserdetailbooked.addRate(
       success: () => Dialogcustom.show(context, "Đã đánh giá"),
       data: requestAddRate,
       e: () => Dialogcustom.show(context, "loi"),
     );
     isLoadingRating.value = false;
   }
}
