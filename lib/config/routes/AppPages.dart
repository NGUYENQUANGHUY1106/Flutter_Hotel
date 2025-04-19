import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/presentation/DetailBookedScreen/binding/DetailBookedBinding.dart';
import 'package:book_hotel/presentation/DetailBookedScreen/view/DetailBookedScreen.dart';
import 'package:book_hotel/presentation/DetailHotelScreen/binding/DetailHotelBinding.dart';
import 'package:book_hotel/presentation/DetailHotelScreen/view/DetailHotelScreen.dart';
import 'package:book_hotel/presentation/HotelDetailBookedScreen/binding/BindingHotelDetailBooked.dart';
import 'package:book_hotel/presentation/HotelDetailBookedScreen/view/HotelDetailBooked.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/binding/HotelIndexBinding.dart';
import 'package:book_hotel/presentation/HotelIndexScreen/view/HotelIndexScreen.dart';
import 'package:book_hotel/presentation/IndexUserScreen/binding/IndexUserBinding.dart';
import 'package:book_hotel/presentation/IndexUserScreen/view/IndexUserScreen.dart';
import 'package:book_hotel/presentation/LoginScreen/binding/LoginBinding.dart';
import 'package:book_hotel/presentation/LoginScreen/view/LoginScreen.dart';
import 'package:book_hotel/presentation/SignUpHotel/binding/SignUpHotelBinding.dart';
import 'package:book_hotel/presentation/SignUpHotel/view/SignUpHotelScreen.dart';
import 'package:book_hotel/presentation/SignUpScreen/binding/SignUpBinding.dart';
import 'package:book_hotel/presentation/SignUpScreen/view/SignUpScreen.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:book_hotel/presentation/VnPayScreen/view/VnpayScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.login,
        page: () => const Loginscreen(),
        binding: Loginbinding()),
    GetPage(
        name: AppRoutes.signUp,
        page: () => const Signupscreen(),
        binding: Signupbinding()),
    GetPage(
        name: AppRoutes.signUpHotel,
        page: () => const SignUpHotelScreen(),
        binding: Signuphotelbinding()),
    GetPage(
        name: AppRoutes.indexuserscreen,
        page: () => const Indexuserscreen(),
        binding: Indexuserbinding()),
    GetPage(
      name: AppRoutes.vnpagePage,
      page: () => const VnPayPage(),
      // binding: BindingControllerIntroduce()
    ),
    GetPage(
        name: AppRoutes.detailHotelScreen,
        page: () => const DetailHotelScreen(),
        binding: Detailhotelbinding()),
    GetPage(
        name: AppRoutes.detailBooked,
        page: () => const Detailbookedscreen(),
        binding: Detailbookedbinding()),
    GetPage(
        name: AppRoutes.hotelIndex,
        page: () => const Hotelindexscreen(),
        binding: Hotelindexbinding()),
    GetPage(
        name: AppRoutes.hotelDetailBooked,
        page: () => const HotelDetailBooked(),
        binding: Bindinghoteldetailbooked()),
  ];
}
