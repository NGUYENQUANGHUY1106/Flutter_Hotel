import 'package:book_hotel/presentation/LoginScreen/controller/ControllerLogin.dart';
import 'package:get/get.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerLogin>(() => ControllerLogin());
  }
}
