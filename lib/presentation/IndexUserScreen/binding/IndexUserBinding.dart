import 'package:book_hotel/presentation/UserBookedScreen/controller/ControllerUserBooked.dart';
import 'package:book_hotel/presentation/UserHomeScreen/controller/ControllerHomeUser.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class Indexuserbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllerhomeuser>(() => Controllerhomeuser());
    Get.lazyPut<Controlleruserbooked>(() => Controlleruserbooked());
  }
}
