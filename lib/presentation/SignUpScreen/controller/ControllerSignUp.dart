import 'package:book_hotel/Model/CustomerModel.dart';
import 'package:book_hotel/Model/UserModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/util/izi_validate.dart';
import 'package:book_hotel/data/repository/RepositorySignUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class Controllersignup extends GetxController {
  Repositorysignup repositorysignup = GetIt.I<Repositorysignup>();

  final isLoading = false.obs;

  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();

  void signUp(BuildContext context) async {
    bool check = isValidate(context);
    if (check) {
      isLoading.value = true;
      final user = UserModel(email: email.text, password: pass1.text);
      final customer =
          CustomerModel(phone: phone.text, user: user, username: username.text);
      await repositorysignup.signUp(
        data: customer,
        success: () {
          Dialogcustom.show(context, "Tạo tài khoản thành công");

          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(AppRoutes.login);
          });
        },
        error: (e) => Dialogcustom.show(context, e, isSuccess: false),
      );
      isLoading.value = false;
    }
  }

 bool isValidate(BuildContext context) {
  if (IZIValidate.nullOrEmpty(username.text.trim())) {
    Dialogcustom.show(context, "Tên không được trống", isSuccess: false);
    return false;
  }

  if (IZIValidate.nullOrEmpty(email.text.trim())) {
    Dialogcustom.show(context, "Email không được trống", isSuccess: false);
    return false;
  }

  if (!email.text.trim().endsWith("@gmail.com")) {
    Dialogcustom.show(context, "Email phải có đuôi @gmail.com", isSuccess: false);
    return false;
  }

  if (IZIValidate.nullOrEmpty(phone.text.trim())) {
    Dialogcustom.show(context, "Số điện thoại không được trống", isSuccess: false);
    return false;
  }

  if (!RegExp(r'^[0-9]+$').hasMatch(phone.text.trim())) {
    Dialogcustom.show(context, "Số điện thoại chỉ được chứa số", isSuccess: false);
    return false;
  }

  if (IZIValidate.nullOrEmpty(pass1.text.trim()) ||
      IZIValidate.nullOrEmpty(pass2.text.trim())) {
    Dialogcustom.show(context, "Password không được trống", isSuccess: false);
    return false;
  }

  if (pass1.text != pass2.text) {
    Dialogcustom.show(context, "Mật khẩu không khớp", isSuccess: false);
    return false;
  }

  return true;
}

  
}
