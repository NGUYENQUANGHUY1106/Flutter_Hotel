import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/UserBookedScreen/controller/ControllerUserBooked.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Userbookedscreen extends GetView<Controlleruserbooked> {
  const Userbookedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              body: RefreshIndicator(
                onRefresh: () => controller.getAllBookedHotel(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: ListView.builder(
                    itemCount: controller.bookedHotels.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: BoxBookedHotel(
                        bookHotel: controller.bookedHotels[index],
                      ),
                    ),
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
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookHotel.hotel!.username!,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  const ShowRateStart(
                    avgRate: 4.5,
                    size: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Expanded(
                        child: Text(
                          "${bookHotel.hotel!.address!.detailPlace}, ${bookHotel.hotel!.address!.town}, ${bookHotel.hotel!.address!.district}, ${bookHotel.hotel!.address!.province}",
                          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:
                                bookHotel.statusBook == Enumstatusbook.WAIT.name
                                    ? Colors.yellow
                                    : bookHotel.statusBook ==
                                            Enumstatusbook.CANCELLED.name
                                        ? Colors.red
                                        : Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 2),
                        child: Text(
                          bookHotel.statusBook! == Enumstatusbook.WAIT.name
                              ? "Chờ xác nhận"
                              : bookHotel.statusBook ==
                                      Enumstatusbook.CANCELLED.name
                                  ? "Đã hủy"
                                  : "Đã xác nhận",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.white),
                        ),
                      ),
                      Text("${bookHotel.totalPrice}k",
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500))
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
