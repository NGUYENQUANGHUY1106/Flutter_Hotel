import 'package:book_hotel/presentation/LoadingScreen.dart';
import 'package:book_hotel/presentation/UserHomeScreen/controller/ControllerHomeUser.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/BoxItemHotel.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/BoxSearchHomeUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/BoxListCityGrid.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/SimpleImageSlider.dart';

class UserHomeScreen extends GetView<Controllerhomeuser> {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              body: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: BoxSearchHomeUser(),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 430,
                      child: BoxListCityGRid(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "HOTEL",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: controller.hotels.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 200,
                              margin: const EdgeInsets.only(right: 10),
                              child:
                                  BoxItemHotel(hotel: controller.hotels[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: SimpleImageSlider(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ShowRateStart extends StatelessWidget {
  final double avgRate;
  final double size;

  const ShowRateStart({super.key, required this.avgRate, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < avgRate.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < avgRate && avgRate % 1 != 0) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }
}
