import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/controller/ControllerHotelIndex.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Hotelindexscreen extends GetView<Controllerhotelindex> {
  const Hotelindexscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              appBar: AppBar(
                  actions: [
                    Obx(
                      () => Text(
                        "Doanh thu : ${controller.money.value}k",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    IconButton(
                        onPressed: () => controller.getDoanhThu(),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.red,
                        ))
                  ],
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                  )),
              body: RefreshIndicator(
                onRefresh: () => controller.getAllBookedOfHotel(),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: ListView.builder(
                      itemCount: controller.bookedHotels.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: HotelBoxBooked(
                              bookHotelModel: controller.bookedHotels[index],
                            ),
                          )),
                ),
              ),
            ),
    );
  }
}

class HotelBoxBooked extends StatelessWidget {
  final BookHotelModel bookHotelModel;
  const HotelBoxBooked({super.key, required this.bookHotelModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.hotelDetailBooked, arguments: bookHotelModel),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            SizedBox(
              width: 140,
              height: double.infinity,
              child: CacheImgCustom(url: bookHotelModel.hotel!.img!),
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
                    bookHotelModel.hotel!.username!,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
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
                          "${bookHotelModel.hotel!.address!.detailPlace} ,${bookHotelModel.hotel!.address!.town} ,${bookHotelModel.hotel!.address!.district} ,${bookHotelModel.hotel!.address!.province}",
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
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 2),
                        child: Text(
                          bookHotelModel.statusBook!,
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.white),
                        ),
                      ),
                      Text("${bookHotelModel.totalPrice}k",
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