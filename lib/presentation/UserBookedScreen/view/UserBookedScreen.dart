import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/UserBookedScreen/controller/ControllerUserBooked.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:book_hotel/core/util/format_utils.dart';

import 'package:get/get.dart';

class UserBookedScreen extends GetView<ControllerUserBooked> {
  const UserBookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? filterStatus = Get.arguments;

    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              appBar: AppBar(
                title: const Text('Danh sách đặt phòng'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () => controller.getAllBookedHotel(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView(
                    children: controller.bookedHotels
                        .where((book) => filterStatus == null || book.statusBook == filterStatus)
                        .map((book) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: BoxBookedHotel(bookHotel: book),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
    );
  }
}

class BoxBookedHotel extends StatelessWidget {
  final BookHotelModel bookHotel;

  const BoxBookedHotel({super.key, required this.bookHotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detailBooked, arguments: bookHotel),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            SizedBox(
              width: 140,
              height: double.infinity,
              child: CacheImgCustom(url: bookHotel.hotel!.img!),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookHotel.hotel!.username!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  const ShowRateStart(avgRate: 4.5, size: 20),
                  Row(
                    children: [
                      const Icon(Icons.place, color: Colors.red),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: Text(
                          "${bookHotel.hotel!.address!.detailPlace}, ${bookHotel.hotel!.address!.town}, ${bookHotel.hotel!.address!.district}, ${bookHotel.hotel!.address!.province}",
                          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: bookHotel.statusBook == Enumstatusbook.WAIT.name
                              ? Colors.yellow
                              : bookHotel.statusBook == Enumstatusbook.CANCELLED.name
                                  ? Colors.red
                                  : bookHotel.statusBook == Enumstatusbook.CHECKOUT.name
                                      ? Colors.grey
                                      : Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2),
                        child: Text(
                          bookHotel.statusBook == Enumstatusbook.WAIT.name
                              ? "Chờ xác nhận"
                              : bookHotel.statusBook == Enumstatusbook.CANCELLED.name
                                  ? "Đã hủy"
                                  : bookHotel.statusBook == Enumstatusbook.CHECKOUT.name
                                      ? "Đã trả phòng"
                                      : "Đã xác nhận",
                          style: TextStyle(fontSize: 13.sp, color: Colors.white),
                        ),
                      ),
                      Text("${formatCurrency(bookHotel.totalPrice)} / Ngày ",
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
