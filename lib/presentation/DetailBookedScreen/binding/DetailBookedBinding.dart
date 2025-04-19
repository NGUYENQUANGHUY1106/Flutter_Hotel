import 'package:book_hotel/presentation/DetailBookedScreen/controller/ControllerDetailBooked.dart';
import 'package:get/get.dart';

class Detailbookedbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllerdetailbooked>(() => Controllerdetailbooked());
  }
}
