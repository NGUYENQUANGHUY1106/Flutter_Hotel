import 'package:book_hotel/presentation/HotelIndexScreen/controller/ControllerHotelIndex.dart';
import 'package:get/get.dart';

class Hotelindexbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllerhotelindex>(() => Controllerhotelindex());
  }
}
