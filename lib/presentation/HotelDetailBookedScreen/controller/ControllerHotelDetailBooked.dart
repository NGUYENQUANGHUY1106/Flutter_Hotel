import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/data/repository/RepositoryUserDetailBooked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

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

  @override
  void onInit() {
    super.onInit();

    // Thiết lập dữ liệu ngày đặt phòng
    startDate.text = format.format(bookedHotel.value.bookStart!);
    endDate.text = format.format(bookedHotel.value.bookEnd!);

    // Thiết lập số lượng phòng
    count.text = bookedHotel.value.countRoom.toString();

    // Thiết lập loại giường và hạng phòng
    selectedBedType.value = bookedHotel.value.bedType ?? 'Giường đơn';
    selectedRoomType.value = bookedHotel.value.roomType ?? 'Standard';
  }

  void clickConfirm(BuildContext context) async {
    isLoading.value = true;

    await repositoryUserDetailBooked.updateStatusBooked(
      bookedHotel.value.id!,
      Enumstatusbook.COMFIRMED.name,
      success: (data) => bookedHotel.value = data,
      e: () => Dialogcustom.show(context, "Lỗi xác nhận", isSuccess: false),
    );

    isLoading.value = false;
  }
}
