import 'package:book_hotel/Model/ProvinceVn.dart';
import 'package:book_hotel/core/BaseWidget/CustomDropdown.dart';
import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/SignUpHotel/controller/ControllerSignUpHotel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpHotelScreen extends GetView<Controllersignuphotel> {
  const SignUpHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              backgroundColor: UtilColors.primaryKeyColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/img/logo.png"),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.r))),
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 30.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Đăng ký tài khoản khách sạn",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: UtilColors.primaryKeyColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextField(
                            controller: controller.username,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_box_outlined),
                                label: Text("Tên khách sạn"),
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
                          Obx(
                            () => CustomDropdown<ProvinceVn>(
                              value: controller.province,
                              items: controller.provinces.value,
                              label: 'Chọn tỉnh thành',
                              itemLabelBuilder: (item) => item.name,
                              onChanged: (newValue) {
                                controller.province = newValue;
                                controller.getDistricts();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Obx(
                            () => CustomDropdown<Districts>(
                              value: controller.district,
                              items: controller.districts.value,
                              label: 'Chọn quận/huyện',
                              itemLabelBuilder: (item) => item.name,
                              onChanged: (newValue) {
                                controller.district = newValue;
                                controller.getTowns();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Obx(
                            () => CustomDropdown<Town>(
                              value: controller.town,
                              items: controller.towns.value,
                              label: 'Chọn xã/phường',
                              itemLabelBuilder: (item) => item.name,
                              onChanged: (newValue) {
                                controller.town = newValue;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.detailPlace,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.place),
                                label: Text("Địa chỉ chính xác"),
                                hintText: "Nhập địa chỉ chính xác"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: controller.price,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.money),
                                label: Text("Giá phòng /đêm"),
                                hintText: "Nhập giá phòng /đêm"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: UtilColors.colorTextField,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                ),
                                width: 180.w,
                                height: 120.w,
                                child: controller.selectedImage.value == null
                                    ? const Icon(
                                        Icons.image,
                                        color: UtilColors.primaryKeyColor,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.file(
                                          controller.selectedImage.value!,
                                          fit: BoxFit.cover,
                                          width: 180.w,
                                          height: 120.w,
                                        ),
                                      ),
                              ),
                            ),
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
                          SizedBox(
                            height: 20.h,
                          ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
