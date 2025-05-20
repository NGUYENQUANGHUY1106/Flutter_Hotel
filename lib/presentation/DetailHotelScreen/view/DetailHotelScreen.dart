import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/presentation/DetailHotelScreen/controller/ControllerDetaiHotel.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HotelDetailScreen extends GetView<ControllerDetaiHotel> {
  const HotelDetailScreen({super.key}); // ✅ Đúng 1 constructor duy nhất
  // const DetailHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: CacheImgCustom(url: controller.hotel.img!),
                ),
                Positioned(
                  top: 20.h,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.refresh, color: Colors.blue),
                            onPressed: () async {
                              await controller
                                  .fetchHotelDetail(controller.hotel.id!);
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              await controller.toggleFavoriteHotel();
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 25.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.hotel.username ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShowRateStart(
                            avgRate: 4.5,
                            size: 23.w,
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.green,
                            ),
                            child: Text(
                              "4.5/5.0",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          color: Colors.red,
                        ),
                        child: Text(
                          "${controller.hotel.price ?? 0} VNĐ/đêm",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      const Icon(Icons.place, color: Colors.red),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: Text(
                          "${controller.hotel.address?.detailPlace ?? ''}, ${controller.hotel.address?.town ?? ''}, ${controller.hotel.address?.district ?? ''}, ${controller.hotel.address?.province ?? ''}",
                          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () =>
                        controller.selectDate(context, controller.startDate),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: controller.startDate,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          hintText: "Ngày nhận phòng",
                          label: Text("Ngày nhận phòng"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () =>
                        controller.selectDate(context, controller.endDate),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: controller.endDate,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          hintText: "Ngày trả phòng",
                          label: Text("Ngày trả phòng"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
// Ô chọn giờ nhận phòng
                  Obx(() => GestureDetector(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 14, minute: 0),
                          );
                          if (picked != null) {
                            controller.checkInTime.value = picked;
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              hintText: "Chọn giờ nhận phòng",
                              label: Text("Giờ nhận phòng"),
                            ),
                            controller: TextEditingController(
                              text: controller.checkInTime.value != null
                                  ? controller.checkInTime.value!
                                      .format(context)
                                  : "",
                            ),
                          ),
                        ),
                      )),

                  SizedBox(height: 20.h),
                  Obx(() => GestureDetector(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 0),
                          );
                          if (picked != null) {
                            controller.checkOutTime.value = picked;
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              hintText: "Chọn giờ trả phòng",
                              label: Text("Giờ trả phòng"),
                            ),
                            controller: TextEditingController(
                              text: controller.checkOutTime.value != null
                                  ? controller.checkOutTime.value!
                                      .format(context)
                                  : "",
                            ),
                          ),
                        ),
                      )),

                  SizedBox(height: 20.h),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int count = 0;
                      try {
                        count = int.parse(value);
                        controller.onChangeRoom(count, context);
                      } catch (e) {}
                    },
                    decoration: const InputDecoration(
                      label: Text("Bạn muốn đặt mấy phòng?"),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(() => Row(
                        children: [
                          Icon(Icons.meeting_room, color: Colors.green),
                          SizedBox(width: 6),
                          Text(
                            'Số phòng trống: ${controller.hotelDetail.value?.room ?? controller.hotel.room ?? 0}',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  "${controller.totalPrice} VND",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                  ),
                )),
            ElevatedButton(
              onPressed: () => controller.bookHotel(context),
              child: const Text("Đặt phòng"),
            ),
          ],
        ),
      ),
    );
  }
}
