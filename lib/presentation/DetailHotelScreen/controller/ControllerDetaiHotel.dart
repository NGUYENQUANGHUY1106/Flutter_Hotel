import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/config/routes/appRoutes.dart';
import 'package:book_hotel/core/BaseWidget/DialogCustom.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryDetailHotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ControllerDetaiHotel extends GetxController {
  final Repositorydetailhotel repositorydetailhotel =
      GetIt.I<Repositorydetailhotel>();
  final HotelModel hotel = Get.arguments as HotelModel;

  final dio = Dio();
  var hotelDetail = Rxn<HotelModel>();
  final totalPrice = 0.obs;
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final format = DateFormat('dd/MM/yyyy');
  late final SharedPreferences prefs;
  int count = 0;

  final checkInTime = Rx<TimeOfDay?>(null);
  final checkOutTime = Rx<TimeOfDay?>(null);
  final selectedBedType = 'Giường đơn'.obs;
  final selectedRoomType = 'Standard'.obs;

  @override
  void onInit() {
    super.onInit();
    prefs = GetIt.I<SharedPreferences>();
    fetchHotelDetail(hotel.id!);
  }

  Future<void> fetchHotelDetail(int idHotel) async {
    try {
      final response =
          await dio.get("http://192.168.88.53:8080/hotel/$idHotel");
      hotelDetail.value = HotelModel.fromMap(response.data);
      hotel.room = hotelDetail.value?.room;
      hotel.price = hotelDetail.value?.price;
      hotel.username = hotelDetail.value?.username;
      hotel.address = hotelDetail.value?.address;
      hotel.img = hotelDetail.value?.img;
    } catch (e) {
      print('Loi fetchHotelDetail: $e');
    }
  }

  void selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.text = format.format(pickedDate);
    }
  }

  void onChangeRoom(int count, BuildContext context) {
    if (startDate.text.isEmpty || endDate.text.isEmpty) {
      Dialogcustom.show(context, "Điền thông tin ngày", isSuccess: false);
      return;
    }
    this.count = count;
    int totalDays = getTotalDays(startDate.text, endDate.text);
    int price = hotelDetail.value?.price ?? hotel.price ?? 0;
    totalPrice.value = totalDays * price * count;
  }

  int getTotalDays(String start, String end) {
    final startParsed = format.parse(start);
    final endParsed = format.parse(end);
    return endParsed.difference(startParsed).inDays;
  }

void updateTotalPrice() {
  int basePrice = hotel.price ?? 0;

  // Cộng thêm theo loại giường
  if (selectedBedType.value == 'Giường đôi') {
    basePrice += 300000;
  }

  // Cộng thêm theo hạng phòng
  if (selectedRoomType.value == 'Deluxe') {
    basePrice += 300000;
  } else if (selectedRoomType.value == 'VIP') {
    basePrice += 500000;
  }

  int days = getTotalDays(startDate.text, endDate.text);
int roomCount = count;

  totalPrice.value = basePrice * days * roomCount;
}


  void bookHotel(BuildContext context) async {
  int idUser = await getIdUser();

  DateTime? start;
  DateTime? end;

  try {
    start = format.parse(startDate.text);
    end = format.parse(endDate.text);
  } catch (e) {
    Dialogcustom.show(context, "Vui lòng chọn đúng định dạng ngày",
        isSuccess: false);
    return;
  }

  // ✅ Kiểm tra ngày nhận phòng phải từ hôm nay trở đi
  if (start.isBefore(DateTime.now())) {
    Dialogcustom.show(context, "Ngày nhận phòng phải từ hôm nay trở đi",
        isSuccess: false);
    return;
  }

  // ✅ Kiểm tra ngày trả phòng phải sau hoặc bằng ngày nhận phòng
  if (!end.isAfter(start) && end != start) {
    Dialogcustom.show(context, "Ngày trả phòng phải sau hoặc bằng ngày nhận phòng",
        isSuccess: false);
    return;
  }

  // ✅ Kiểm tra giờ nếu cùng 1 ngày
  if (start.isAtSameMomentAs(end) &&
      checkInTime.value != null &&
      checkOutTime.value != null) {
    final checkIn = checkInTime.value!;
    final checkOut = checkOutTime.value!;
    final inMinutes = checkIn.hour * 60 + checkIn.minute;
    final outMinutes = checkOut.hour * 60 + checkOut.minute;

    if (outMinutes <= inMinutes) {
      Dialogcustom.show(
          context, "Giờ trả phòng phải sau giờ nhận phòng", isSuccess: false);
      return;
    }
  }

  // ✅ Kiểm tra số lượng phòng
  if (count <= 0) {
    Dialogcustom.show(context, "Số lượng phòng phải lớn hơn 0",
        isSuccess: false);
    return;
  }

  // ✅ Format giờ nhận/trả
  final timeFormat = DateFormat.Hm(); // HH:mm
  String? checkInFormatted = checkInTime.value != null
      ? timeFormat.format(DateTime(
          0, 1, 1, checkInTime.value!.hour, checkInTime.value!.minute))
      : null;

  String? checkOutFormatted = checkOutTime.value != null
      ? timeFormat.format(DateTime(
          0, 1, 1, checkOutTime.value!.hour, checkOutTime.value!.minute))
      : null;

  // ✅ Tạo request
  final data = RequestBookHotelModel(
    idUser: idUser,
    idHotel: hotel.id!,
    totalPrice: totalPrice.value,
    countRoom: count,
    bookStart: start,
    bookEnd: end,
    checkinTime: checkInFormatted,
    checkoutTime: checkOutFormatted,
    bedType: selectedBedType.value,
    roomType: selectedRoomType.value,
  );

  // ✅ Gửi yêu cầu đặt phòng
  await repositorydetailhotel.bookHotel(
    data: data,
    success: () {
      Dialogcustom.show(context, "Đặt phòng thành công");
    },
    e: () {
      Dialogcustom.show(context, "Đặt phòng thất bại", isSuccess: false);
    },
  );
}


  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }

  Future<void> toggleFavoriteHotel() async {
    try {
      final userId = await getIdUser();
      final hotelId = hotel.id;
      await dio.post(
          "http://192.168.88.53:8080/mvc_10/api/favorite/toggle/$userId/$hotelId");
      print(" Đã yêu thích khách sạn!");
    } catch (e) {
      print(" Lỗi khi yêu thích khách sạn: $e");
    }
  }
}
