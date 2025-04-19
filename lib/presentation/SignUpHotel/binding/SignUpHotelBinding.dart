import 'package:book_hotel/presentation/SignUpHotel/controller/ControllerSignUpHotel.dart';
import 'package:get/get.dart';

class Signuphotelbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controllersignuphotel>(() => Controllersignuphotel());
  }
}
