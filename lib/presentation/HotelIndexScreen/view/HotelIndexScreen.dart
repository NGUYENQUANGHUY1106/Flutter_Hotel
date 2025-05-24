import 'package:book_hotel/presentation/HotelIndexScreen/controller/ControllerHotelIndex.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/view/BookingListScreen.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
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
                title: Text("Tài khoản quản lý khách sạn"),
                actions: [
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Center(
                        child: Text(
                          "Doanh thu: ${controller.money.value.toStringAsFixed(0)}k",
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await controller.getDoanhThu();
                      await controller.getBookingStatusCount();
                      await controller.getAvailableRooms();
                      await controller.getAllBookedOfHotel();
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              body: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildItem(Icons.hotel_class_outlined, "Khách Sạn Đã Đặt",
                      controller.checkoutCount.value, () async {
                    final result = await Get.to(() => BookingListScreen(
                          title: "Khách Sạn Đã Đặt",
                          statusFilter: 'CHECKOUT',
                        ));
                    if (result == true) {
                      await _refreshData();
                    }
                  }),
                  _buildItem(Icons.hourglass_empty, "Đang Chờ",
                      controller.waitCount.value, () async {
                    final result = await Get.to(() => BookingListScreen(
                          title: "Đang Chờ Xác Nhận",
                          statusFilter: 'WAIT',
                        ));
                    if (result == true) {
                      await _refreshData();
                    }
                  }),
                  _buildItem(Icons.check_circle, "Đã Duyệt",
                      controller.confirmedCount.value, () async {
                    final result = await Get.to(() => BookingListScreen(
                          title: "Đã Duyệt",
                          statusFilter: 'CONFIRMED',
                        ));
                    if (result == true) {
                      await _refreshData();
                    }
                  }),
                  _buildItem(Icons.cancel, "Đã Hủy",
                      controller.cancelledCount.value, () async {
                    final result = await Get.to(() => BookingListScreen(
                          title: "Đã Hủy",
                          statusFilter: 'CANCELLED',
                        ));
                    if (result == true) {
                      await _refreshData();
                    }
                  }),
                  _buildItem(Icons.logout, "Đã Trả Phòng",
                      controller.returnedCount.value, () async {
                    final result = await Get.to(() => BookingListScreen(
                          title: "Đã Trả Phòng",
                          statusFilter: 'RETURNED',
                        ));
                    if (result == true) {
                      await _refreshData();
                    }
                  }),
                  _buildItem(Icons.meeting_room_outlined, "Số phòng trống",
                      controller.availableRooms.value, () {
                    Get.snackbar("Thông báo",
                        "Tổng số phòng trống hiện tại: ${controller.availableRooms.value}");
                  }),
                  _buildItem(Icons.headset_mic, "Hỗ Trợ Khách Hàng", 0, () {
                    // TODO: Điều hướng đến trang hỗ trợ khách hàng
                  }),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Đăng xuất
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text("Đăng xuất",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
    );
  }

  /// Tạo widget danh sách
  Widget _buildItem(
      IconData icon, String title, int count, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text("$title ($count)"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  /// Làm mới dữ liệu sau mỗi lần trở về
  Future<void> _refreshData() async {
    await controller.getAllBookedOfHotel();
    await controller.getBookingStatusCount();
    await controller.getAvailableRooms();
    await controller.getDoanhThu();
  }
}
