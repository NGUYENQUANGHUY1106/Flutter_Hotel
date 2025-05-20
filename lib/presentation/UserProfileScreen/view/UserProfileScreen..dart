import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/presentation/UserHomeScreen/controller/ControllerHomeUser.dart';

class UserProfileScreen extends GetView<Controllerhomeuser> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = controller.customer.value?.user?.id;
      if (userId != null) {
        controller
            .fetchCounts(userId); // Tự động cập nhật khi quay lại màn hình
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage("assets/img/img1.jpg"),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chào quý khách",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(() {
                          final email = controller.customer.value?.user?.email;
                          return Text(
                            email ?? "Chưa đăng nhập",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          );
                        }),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.customer.value = null;
                      Get.offAllNamed(AppRoutes.login);
                    },
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
              SizedBox(height: 30.h),

              // List options
              Expanded(
                child: Obx(() {
                  final userId = controller.customer.value?.user?.id;
                  if (userId == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
  children: [
    ListTile(
      leading: const Icon(Icons.favorite, color: Colors.red),
      title: Text("Khách Sạn Yêu Thích (${controller.favoriteCount})"),
      onTap: () => Get.toNamed('/favorites'),
    ),
    ListTile(
      leading: const Icon(Icons.schedule, color: Colors.orange),
      title: Text("Đang Chờ Xác Nhận (${controller.bookingCounts['WAIT'] ?? 0})"),
      onTap: () => Get.toNamed('/bookings', arguments: 'WAIT'),
    ),
    ListTile(
      leading: const Icon(Icons.verified_user, color: Colors.teal),
      title: Text("Đã Duyệt Phòng (${controller.bookingCounts['COMFIRMED'] ?? 0})"),
      onTap: () => Get.toNamed('/bookings', arguments: 'COMFIRMED'),
    ),
    ListTile(
      leading: const Icon(Icons.meeting_room_outlined, color: Colors.grey),
      title: Text("Đã Trả Phòng (${controller.bookingCounts['CHECKOUT'] ?? 0})"),
      onTap: () => Get.toNamed('/bookings', arguments: 'CHECKOUT'),
    ),
    ListTile(
      leading: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
      title: Text("Đã Hủy (${controller.bookingCounts['CANCELLED'] ?? 0})"),
      onTap: () => Get.toNamed('/bookings', arguments: 'CANCELLED'),
    ),
  ],
)
;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
