import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/SignUpScreen/controller/ControllerSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Signupscreen extends GetView<Controllersignup> {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: UtilColors.primaryKeyColor,
              body: Column(
                children: [
                  Image.asset("assets/img/logo.png"),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.r))),
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 30.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Đăng ký tài khoản người dùng",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: UtilColors.primaryKeyColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Spacer(),
                          TextField(
                            controller: controller.username,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_box_outlined),
                                label: Text("Họ tên"),
                                hintText: "Nhập họ tên"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.email,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text("Email"),
                                hintText: "Nhập email"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.phone,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                label: Text("Số điện thoại"),
                                hintText: "Nhập số điện thoại"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.pass1,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                label: Text("Password"),
                                hintText: "Nhập Password"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.pass2,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                label: Text("Xác nhận password"),
                                hintText: "Nhập Xác nhận password"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 45.h,
                              child: ElevatedButton(
                                  onPressed: () => controller.signUp(context),
                                  child: Text(
                                    "Đăng ký",
                                    style: TextStyle(fontSize: 16.sp),
                                  ))),
                          const Spacer(),
                          Row(
                            children: [
                              const Text("Bạn đã có tài khoản ?"),
                              SizedBox(
                                width: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Text(
                                      "đăng nhập",
                                      style: TextStyle(
                                          color: UtilColors.primaryKeyColor,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
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
                ],
              ),
            ),
    );
  }
}
