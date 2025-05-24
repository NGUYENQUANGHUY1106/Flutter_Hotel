import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/controller/ControllerHotelIndex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookingListScreen extends StatelessWidget {
  final String title;
  final String statusFilter;

  const BookingListScreen({
    super.key,
    required this.title,
    required this.statusFilter,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Controllerhotelindex>();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Obx(() {
        final bookings = controller.getBookingsByStatus(statusFilter);

        if (bookings.isEmpty) {
          return const Center(child: Text("Không có dữ liệu"));
        }

        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            final hotel = booking.hotel;
            final address = hotel?.address;

            return GestureDetector(
              onTap: () async {
                // Chuyển sang màn hình chi tiết
                final result = await Get.toNamed(
                  AppRoutes.hotelDetailBooked,
                  arguments: booking,
                );

                // Nếu có cập nhật từ màn hình chi tiết, cập nhật lại controller
                if (result == true) {
                  await controller.getAllBookedOfHotel();
                  await controller.getBookingStatusCount();
                  await controller.getAvailableRooms();
                  await controller.getDoanhThu();
                  controller.bookedHotels.refresh();
                }
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10.w),
                  leading: SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: CacheImgCustom(url: hotel?.img ?? ''),
                  ),
                  title: Text(
                    hotel?.username ?? 'Chưa rõ tên',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      address != null
                          ? "${address.detailPlace ?? ''}, ${address.town ?? ''}, ${address.district ?? ''}, ${address.province ?? ''}"
                          : 'Không có địa chỉ',
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey[700]),
                    ),
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          booking.statusBook ?? '',
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${booking.totalPrice?.toStringAsFixed(0) ?? '0'}k",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
