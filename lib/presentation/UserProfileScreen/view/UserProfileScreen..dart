import 'package:book_hotel/presentation/UserHomeScreen/controller/ControllerHomeUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class UserProfileScreen extends GetView<Controllerhomeuser> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(200))),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/img/img1.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chào quý khách",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        Obx(
                          () => Text(
                              "${controller.customer.value?.user?.email}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                        )
                      ],
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.login))
              ],
            )
          ],
        ),
      ),
    );
  }
}
