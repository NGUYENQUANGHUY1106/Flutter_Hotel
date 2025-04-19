import 'package:book_hotel/presentation/HotelDetailBookedScreen/controller/ControllerHotelDetailBooked.dart';
import 'package:get/get.dart';

class Bindinghoteldetailbooked extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllerhoteldetailbooked>(
        () => Controllerhoteldetailbooked());
  }
}
