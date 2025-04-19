import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/data/repository/RepositoryUserDetailBooked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class Controllerhoteldetailbooked extends GetxController {
  Repositoryuserdetailbooked repositoryuserdetailbooked =
      GetIt.I<Repositoryuserdetailbooked>();
  final bookedHotel = (Get.arguments as BookHotelModel).obs;
  final format = DateFormat('dd/MM/yyyy');
  final isLoading = false.obs;
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final count = TextEditingController();

  @override
  void onInit() {
    startDate.text = format.format(bookedHotel.value.bookStart!);
    endDate.text = format.format(bookedHotel.value.bookEnd!);
    count.text = bookedHotel.value.countRoom.toString();
    super.onInit();
  }

  void clickConfirm(BuildContext context) async {
    isLoading.value = true;
    await repositoryuserdetailbooked.updateStatusBooked(
      bookedHotel.value.id!,
      Enumstatusbook.COMFIRMED.name,
      success: (data) => bookedHotel.value = data,
      e: () => Dialogcustom.show(context, "loi huy"),
    );
    isLoading.value = false;
  }
}
