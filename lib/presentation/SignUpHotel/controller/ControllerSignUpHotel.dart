import 'dart:convert';
import 'dart:io';

import 'package:book_hotel/Model/AddressModel.dart';
import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/ProvinceVn.dart';
import 'package:book_hotel/Model/UserModel.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/util/izi_validate.dart';
import 'package:book_hotel/data/repository/RepositoryHotelSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class Controllersignuphotel extends GetxController {
  Repositoryhotelsignup repositoryhotelsignup =
      GetIt.I<Repositoryhotelsignup>();

  final username = TextEditingController();
  final provinces = <ProvinceVn>[].obs;
  final districts = <Districts>[].obs;
  final towns = <Town>[].obs;
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  final detailPlace = TextEditingController();
  final price = TextEditingController();

  final pathData = 'assets/data/ProvinceData.json';

  ProvinceVn? province;
  Districts? district;
  Town? town;

  final isLoading = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    getProvinces();
  }

  void signUp(BuildContext context) async {
    bool checkIsValidate = isValidate(context);
    if (checkIsValidate) {
      try {
        String? img =
            await repositoryhotelsignup.uploadImage(selectedImage.value!);
        if (img == null) return;
        final userModel = UserModel(email: email.text, password: pass1.text);
        final address = AddressModel(
            province: province!.name,
            district: district!.name,
            town: town!.name,
            detailPlace: detailPlace.text);
        final hotel = HotelModel(
            address: address,
            img: img,
            user: userModel,
            price: int.tryParse(price.text),
            username: username.text);
        isLoading.value = true;
        await repositoryhotelsignup.signUp(
            hotel: hotel,
            success: () {
              Dialogcustom.show(context, "Bạn đã đăng ký tài khoản thành công");
            },
            error: (e) {
              Dialogcustom.show(context, e, isSuccess: false);
            });
        isLoading.value = false;
      } catch (e) {
        print(e);
      }
    }
  }

  void getProvinces() async {
    String jsonString = await rootBundle.loadString(pathData);
    Map<String, dynamic> mapData = jsonDecode(jsonString);
    List<dynamic> listData = mapData['province'];
    provinces.clear();
    provinces.value = listData.map((e) => ProvinceVn.fromMap(e)).toList();
  }

  void getDistricts() async {
    if (province != null) {
      String jsonString = await rootBundle.loadString(pathData);
      Map<String, dynamic> mapData = jsonDecode(jsonString);
      List<dynamic> listData = mapData['district'];
      districts.clear();
      districts.value = listData
          .where((element) => element['idProvince'] == province!.id)
          .map((e) => Districts.fromMap(e))
          .toList();
      district = districts.first;
      getTowns();
    }
  }

  void getTowns() async {
    if (district != null) {
      String jsonString = await rootBundle.loadString(pathData);
      Map<String, dynamic> mapData = jsonDecode(jsonString);
      List<dynamic> listData = mapData['commune'];
      towns.clear();
      towns.value = listData
          .where((element) => element['idDistrict'] == district!.idDistrict)
          .map((e) => Town.fromMap(e))
          .toList();
      town = towns.first;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
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

    if (IZIValidate.nullOrEmpty(price.text.trim())) {
      Dialogcustom.show(context, "Giá không được trống", isSuccess: false);
      return false;
    }

    if (IZIValidate.nullOrEmpty(pass1.text.trim()) ||
        IZIValidate.nullOrEmpty(pass2.text.trim())) {
      Dialogcustom.show(context, "Password không được trống", isSuccess: false);
      return false;
    }
    if (province == null) {
      Dialogcustom.show(context, "Tỉnh thành không được trống",
          isSuccess: false);
      return false;
    }
    if (district == null) {
      Dialogcustom.show(context, "Quận/Huyện không được trống",
          isSuccess: false);
      return false;
    }
    if (IZIValidate.nullOrEmpty(detailPlace.text.trim())) {
      Dialogcustom.show(context, "Địa chỉ chính xác không được trống",
          isSuccess: false);
      return false;
    }
    if (town == null) {
      Dialogcustom.show(context, "Xã/Phường không được trống",
          isSuccess: false);
      return false;
    }

    if (town == null) {
      Dialogcustom.show(context, "Xã/Phường không được trống",
          isSuccess: false);
      return false;
    }
    if (selectedImage.value == null) {
      Dialogcustom.show(context, "Vui lòng chọn ảnh", isSuccess: false);
      return false;
    }
    if (pass1.text != pass2.text) {
      Dialogcustom.show(context, "Mật khẩu không khớp", isSuccess: false);
      return false;
    }
    return true;
  }
}
