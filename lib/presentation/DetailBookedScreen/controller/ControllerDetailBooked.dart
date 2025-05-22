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
  final dio = Dio();

  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final checkInTimeController = TextEditingController();
  final checkOutTimeController = TextEditingController();

  int c = 0;
  double rateStar = 0;

  final totalMoney = 0.obs;
  final selectedBedType = ''.obs;
  final selectedRoomType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      await getDetailBooked();
      selectedBedType.value = bookedHotel.value.bedType ?? '';
      selectedRoomType.value = bookedHotel.value.roomType ?? '';
      startDate.text = format.format(bookedHotel.value.bookStart!);
      endDate.text = format.format(bookedHotel.value.bookEnd!);
      count.text = bookedHotel.value.countRoom!.toString();
      totalMoney.value = bookedHotel.value.totalPrice!;
      checkInTimeController.text = bookedHotel.value.checkinTime ?? '';
      checkOutTimeController.text = bookedHotel.value.checkoutTime ?? '';
    } catch (e) {
      print("Lỗi fetchData: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDetailBooked() async {
  try {
    final idBookHotel = bookedHotel.value.id!;
final url = "http://192.168.88.53:8080/mvc_10/book_hotel/detail/$idBookHotel";
    print("🔎 Gọi API: $url");

    final response = await dio.get(url);
    if (response.statusCode == 200) {
  bookedHotel.value = BookHotelModel.fromMap(response.data);

  selectedBedType.value = bookedHotel.value.bedType ?? 'Giường đơn';
  selectedRoomType.value = bookedHotel.value.roomType ?? 'Standard';
  checkInTimeController.text = bookedHotel.value.checkinTime ?? '';
  checkOutTimeController.text = bookedHotel.value.checkoutTime ?? '';
  count.text = bookedHotel.value.countRoom.toString();
}

  } catch (e) {
    print(" Lỗi getDetailBooked: $e");
    Dialogcustom.show(Get.context!, "Không tìm thấy đặt phòng!", isSuccess: false);
  }
}


  void onChangeRoom(int count, BuildContext context) {
    if (startDate.text == "" || endDate.text == "") {
      Dialogcustom.show(context, "Điền thông tin ngày");
      return;
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
      e: () => Dialogcustom.show(context, "Lỗi hủy"),
    );
    isLoading.value = false;
  }

  void clickUpdateBookedHotel(BuildContext context) async {
    isLoading.value = true;
    final dataUpdate = RequestBookHotelModel(
      id: bookedHotel.value.id,
      totalPrice: totalMoney.value,
      countRoom: int.tryParse(count.text) ?? 1,
      bookStart: format.parse(startDate.text),
      bookEnd: format.parse(endDate.text),
      checkinTime: checkInTimeController.text,
      checkoutTime: checkOutTimeController.text,
      bedType: selectedBedType.value,
      roomType: selectedRoomType.value,
    );

    await repositoryuserdetailbooked.updateBookedHotel(
      success: (data) => bookedHotel.value = data,
      data: dataUpdate,
      e: () => Dialogcustom.show(context, "Cập nhật lỗi", isSuccess: false),
    );
    isLoading.value = false;
  }

  void clickReturnRoom(BuildContext context) async {
    try {
      final idBookHotel = bookedHotel.value.id!;
      final response = await dio.put(
        "http://192.168.88.53:8080/mvc_10/book_hotel/$idBookHotel/CHECKOUT",
      );
      if (response.statusCode == 200) {
        Dialogcustom.show(context, "Trả phòng thành công");
        await getDetailBooked();
      } else {
        Dialogcustom.show(context, "Trả phòng thất bại", isSuccess: false);
      }
    } catch (e) {
      print("Lỗi clickReturnRoom: $e");
      Dialogcustom.show(context, "Có lỗi xảy ra", isSuccess: false);
    }
  }

  void getAllRate(BuildContext context) async {
    isLoadingRating.value = true;
    rates.clear();
    await repositoryuserdetailbooked.getAllRate(
      success: (rates1) => rates.value = rates1,
      idHotel: bookedHotel.value.hotel!.id!,
      e: () => Dialogcustom.show(context, "Lỗi"),
    );
    isLoadingRating.value = false;
  }

  void clickAddRate(BuildContext context) async {
    isLoadingRating.value = true;
    final requestAddRate = Requestaddrate(
      idHotel: bookedHotel.value.hotel!.id!,
      rateStar: rateStar,
      comment: comment.text,
    );
    await repositoryuserdetailbooked.addRate(
      success: () => Dialogcustom.show(context, "Đã đánh giá"),
      data: requestAddRate,
      e: () => Dialogcustom.show(context, "Lỗi"),
    );
    isLoadingRating.value = false;
  }

  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
    }
  }
}
