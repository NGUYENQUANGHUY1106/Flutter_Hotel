import 'package:book_hotel/presentation/DetailHotelScreen/controller/ControllerDetaiHotel.dart';
import 'package:book_hotel/presentation/SignUpScreen/controller/ControllerSignUp.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class Signupbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllersignup>(() => Controllersignup());
  }
}
