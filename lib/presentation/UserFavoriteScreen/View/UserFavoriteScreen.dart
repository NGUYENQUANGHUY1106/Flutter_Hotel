import 'package:book_hotel/Model/FavoriteHotelModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_hotel/presentation/UserFavoriteScreen/controller/FavoriteHotelController.dart';
import 'package:book_hotel/core/util/format_utils.dart';

class UserFavoriteScreen extends StatelessWidget {
  const UserFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteHotelController());
    controller.fetchFavorites(); // Load khi màn hình mở

    return Scaffold(
      appBar: AppBar(title: const Text('Khách sạn yêu thích')),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text('Chưa có khách sạn yêu thích nào.'));
        }
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final hotel = controller.favorites[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network(hotel.hotelImage, width: 60, fit: BoxFit.cover),
                title: Text(hotel.hotelName),
                subtitle: Text('${formatCurrency(hotel.hotelPrice)}  - ${hotel.hotelRating}/5⭐'),
                trailing: Text('Phòng: ${hotel.availableRooms}'),
              ),
            );
          },
        );
      }),
    );
  }
}
