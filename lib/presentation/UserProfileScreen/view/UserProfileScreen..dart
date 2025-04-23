import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/presentation/UserHomeScreen/controller/ControllerHomeUser.dart';

class UserProfileScreen extends GetView<Controllerhomeuser> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    // DÙNG Expanded để hạn chế overflow và cho hiển thị
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
                            softWrap: false,
                          );
                        }),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Bước 1: Xoá dữ liệu người dùng nếu có
                      controller.customer.value = null;

                      // Bước 2: Điều hướng về màn hình login và xoá lịch sử điều hướng
                      Get.offAllNamed(AppRoutes.login);
                    },
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
