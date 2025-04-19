import 'package:book_hotel/presentation/DetailHotelScreen/controller/ControllerDetaiHotel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class Detailhotelbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerDetaiHotel>(() => ControllerDetaiHotel());
  }
}
