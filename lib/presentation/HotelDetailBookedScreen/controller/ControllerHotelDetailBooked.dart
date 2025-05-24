import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/data/repository/RepositoryUserDetailBooked.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/controller/ControllerHotelIndex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class ControllerHotelDetailBooked extends GetxController {
  final Repositoryuserdetailbooked repositoryUserDetailBooked =
      GetIt.I<Repositoryuserdetailbooked>();

  final bookedHotel = (Get.arguments as BookHotelModel).obs;
  final format = DateFormat('dd/MM/yyyy');
  final isLoading = false.obs;

  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final count = TextEditingController();

  final selectedBedType = ''.obs;
  final selectedRoomType = ''.obs;

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();

    // Thiết lập ngày và số lượng phòng
    startDate.text = format.format(bookedHotel.value.bookStart!);
    endDate.text = format.format(bookedHotel.value.bookEnd!);
    count.text = bookedHotel.value.countRoom.toString();

    // Thiết lập loại giường và loại phòng
    selectedBedType.value = bookedHotel.value.bedType ?? 'Giường đơn';
    selectedRoomType.value = bookedHotel.value.roomType ?? 'Standard';
  }

  void clickConfirm(BuildContext context) async {
    isLoading.value = true;

    await repositoryUserDetailBooked.updateStatusBooked(
      bookedHotel.value.id!,
      Enumstatusbook.CONFIRMED.name,
      success: (data) async {
        bookedHotel.value = data;

        // Lấy lại controller để cập nhật lại danh sách
        final controllerHotelIndex = Get.find<Controllerhotelindex>();
        await controllerHotelIndex.getAllBookedOfHotel();
        await controllerHotelIndex.getBookingStatusCount();
        await controllerHotelIndex.getAvailableRooms();
        await controllerHotelIndex.getDoanhThu();
        controllerHotelIndex.bookedHotels.refresh();

        await getDetailBooked(); // Cập nhật lại thông tin chi tiết

        Get.back(result: true); // Thông báo màn hình trước cần refresh
      },
      e: () => Dialogcustom.show(context, "Lỗi xác nhận đặt phòng", isSuccess: false),
    );

    isLoading.value = false;
  }

  Future<void> getDetailBooked() async {
    try {
      final idBookHotel = bookedHotel.value.id!;
      final response = await dio.get("http://192.168.1.43:8080/book_hotel/$idBookHotel");

      if (response.statusCode == 200) {
        bookedHotel.value = BookHotelModel.fromMap(response.data);
      }
    } catch (e) {
      print("Lỗi getDetailBooked (admin): $e");
    }
  }
}
