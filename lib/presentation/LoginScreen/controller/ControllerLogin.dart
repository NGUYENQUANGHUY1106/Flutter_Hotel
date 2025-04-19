import 'package:book_hotel/Model/UserModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/Enum/EnumRole.dart';
import 'package:book_hotel/core/util/JwtUtil.dart';
import 'package:book_hotel/data/repository/RepositoryAuth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ControllerLogin extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;

  Repositoryauth repositoryauth = GetIt.I<Repositoryauth>();

  void login(BuildContext context) async {
    isLoading.value = true;
    UserModel userModel = UserModel(email: email.text, password: password.text);

    await repositoryauth.login(
        user: userModel,
        success: (data) {
          List<String> roles = Jwtutil.getRoles(data["token"]);
          // ignore: collection_methods_unrelated_type
          if (roles.contains(Enumrole.CUSTOMER.name)) {
            Get.toNamed(AppRoutes.indexuserscreen);
          } else if (roles.contains(Enumrole.HOTEL.name)) {
            Get.toNamed(AppRoutes.hotelIndex);
          }
          print(roles);
        },
        error: (message) =>
            Dialogcustom.show(context, message, isSuccess: false));

    isLoading.value = false;
  }
}
