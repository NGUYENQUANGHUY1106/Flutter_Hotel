import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/core/Enum/EnumStatusBook.dart';
import 'package:book_hotel/presentation/DetailBookedScreen/controller/ControllerDetailBooked.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:book_hotel/core/util/format_utils.dart';


class Detailbookedscreen extends GetView<Controllerdetailbooked> {
  const Detailbookedscreen({super.key});

  void showReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: Get.height * .4,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Đánh giá khách sạn",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  controller.rateStar = rating;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.comment,
                decoration: const InputDecoration(
                  hintText: "Nhập bình luận của bạn",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const Spacer(),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.clickAddRate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Gửi đánh giá"),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void showAllReviewsBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final height = MediaQuery.of(context).size.height;

        return Container(
          height: height * 0.6,
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => controller.isLoadingRating.value
                ? const LoadingScreen()
                : Column(
                    children: [
                      const Text(
                        "Tất cả đánh giá",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Obx(
                          () => ListView.separated(
                            itemCount: controller.rates.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                isThreeLine: true,
                                title: Text(controller
                                    .rates[index].customer!.user!.email!),
                                subtitle: Text(
                                  "${controller.rates[index].comment}  ${controller.rates[index].rateStar}⭐ \n"
                                  "${controller.rates[index].createdAt}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 280,
                          child: CacheImgCustom(
                              url: controller.bookedHotel.value.hotel!.img!),
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
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 25.w,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.bookedHotel.value.hotel!.username!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.getAllRate(context);
                                    showAllReviewsBottomSheet(context);
                                  },
                                  child: const Text("Xem đánh giá"))
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  color: Colors.red,
                                ),
                                child: Text(
                                  "${formatCurrency(controller.bookedHotel.value.hotel!.price!)} / Ngày ",
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
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
                                  "${controller.bookedHotel.value.hotel!.address!.detailPlace}, ${controller.bookedHotel.value.hotel!.address!.town}, ${controller.bookedHotel.value.hotel!.address!.district}, ${controller.bookedHotel.value.hotel!.address!.province}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.sp),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: () => controller.selectDate(
                                context, controller.startDate),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.startDate,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_month),
                                    hintText: "Ngày nhận phòng",
                                    label: Text("Ngày nhận phòng")),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () => controller.selectDate(
                                context, controller.endDate),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.endDate,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_month),
                                    hintText: "Ngày trả phòng",
                                    label: Text("Ngày trả phòng")),
                              ),
                            ),
                          ),
                          // Hiển thị giờ nhận phòng
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: controller.bookedHotel.value.statusBook ==
                                    Enumstatusbook.WAIT.name
                                ? () => controller.selectTime(
                                    context, controller.checkInTimeController)
                                : null,
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.checkInTimeController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: "Giờ nhận phòng",
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: controller.bookedHotel.value.statusBook ==
                                    Enumstatusbook.WAIT.name
                                ? () => controller.selectTime(
                                    context, controller.checkOutTimeController)
                                : null,
                            child: AbsorbPointer(
                              child: TextField(
                                controller: controller.checkOutTimeController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: "Giờ trả phòng",
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.count,
                            onChanged: (value) {
                              int count = 0;
                              try {
                                count = int.parse(value);
                                controller.onChangeRoom(count, context);
                              } catch (e) {}
                            },
                            decoration: const InputDecoration(
                                label: Text("Bạn muốn đặt mấy phòng?")),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.r))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.w),
                            child: Text(
                              "${controller.bookedHotel.value.statusBook}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Thời gian đặt phòng : ",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                controller.bookedHotel.value.createdAt
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.blue),
                              )
                            ],
                          ),
                          Visibility(
                            visible:
                                controller.bookedHotel.value.createdBy != null,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Người đặt phòng : ",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.bookedHotel.value.createdBy
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.blue),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                controller.bookedHotel.value.updatedAt != null,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Thời gian cập nhật gần nhất : ",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      controller.bookedHotel.value.updatedAt
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                controller.bookedHotel.value.modifiedBy != null,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Cập nhật bởi : ",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${controller.bookedHotel.value.modifiedBy}",
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                height: 80,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey)]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        "${formatCurrency(controller.totalMoney.value)}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.blue),
                      ),
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: controller.bookedHotel.value.statusBook ==
                              Enumstatusbook.WAIT.name,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 220, 2)),
                            onPressed: () =>
                                controller.clickUpdateBookedHotel(context),
                            child: const Text("Chỉnh sửa"),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Visibility(
                          visible: controller.bookedHotel.value.statusBook ==
                              Enumstatusbook.WAIT.name,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () => controller.clickCancell(context),
                            child: const Text("Hủy phòng"),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Visibility(
                          visible: controller.bookedHotel.value.statusBook ==
                              Enumstatusbook.COMFIRMED.name,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () => showReviewBottomSheet(context),
                            child: const Text("Đánh giá"),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // 🆕 Nút trả phòng mới
                        Visibility(
                          visible: controller.bookedHotel.value.statusBook ==
                              Enumstatusbook.COMFIRMED.name,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () =>
                                controller.clickReturnRoom(context),
                            child: const Text("Trả phòng"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
