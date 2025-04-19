import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/LoginScreen/controller/ControllerLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Loginscreen extends GetView<ControllerLogin> {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: UtilColors.primaryKeyColor,
              body: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.r))),
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 30.h, top: 30.w),
                child: Column(
                  children: [
                    Image.asset("assets/img/logo.png"),
                    SizedBox(
                      height: 10.h,
                    ),
                    
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: UtilColors.primaryKeyColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Spacer(),
                    TextField(
                      controller: controller.email,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text("Email"),
                          hintText: "Nhập email"),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      controller: controller.password,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          label: Text("Password"),
                          hintText: "Nhập Password"),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: ElevatedButton(
                            onPressed: () => controller.login(context),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 16.sp),
                            ))),
                    const Spacer(),
                    Column(
                      children: [
                        const Text("Bạn chưa có tài khoản"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.signUp),
                              child: const Text(
                                "Tạo tài khoản người dùng",
                                style: TextStyle(
                                    color: UtilColors.primaryKeyColor,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.signUpHotel),
                              child: const Text(
                                "Tạo tài khoản khách sạn",
                                style: TextStyle(
                                    color: UtilColors.primaryKeyColor,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
