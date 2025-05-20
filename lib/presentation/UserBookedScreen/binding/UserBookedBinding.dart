import 'package:get/get.dart';
import 'package:book_hotel/presentation/UserBookedScreen/controller/ControllerUserBooked.dart';

class UserBookedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerUserBooked>(() => ControllerUserBooked ());
  }
}
