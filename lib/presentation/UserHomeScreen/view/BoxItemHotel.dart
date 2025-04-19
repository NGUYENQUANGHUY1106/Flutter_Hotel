import 'dart:ui';

import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/CacheImgCustom.dart';
import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoxItemHotel extends StatelessWidget {
  final HotelModel hotel;
  const BoxItemHotel({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detailHotelScreen, arguments: hotel),
      child: Container(
        
        decoration: BoxDecoration(
          
          color: UtilColors.colorBox,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(
              height: 120, 
              width: double.infinity,
              child: CacheImgCustom(url: hotel.img!),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.username!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ShowRateStart(avgRate: 3.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(3.r)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: const Text(
                          "4.9/5.0",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Flexible(
                        child: Text(
                          hotel.address!.province!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${(hotel.price)} / Ngày Đêm",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
