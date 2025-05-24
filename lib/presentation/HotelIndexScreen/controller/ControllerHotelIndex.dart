import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/CustomerModel.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryHotelIndex.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controllerhotelindex extends GetxController {
  final isLoading = false.obs;
  final bookedHotels = <BookHotelModel>[].obs;
  final money = 0.0.obs;

  // Đếm trạng thái
  final waitCount = 0.obs;
  final confirmedCount = 0.obs;
  final cancelledCount = 0.obs;
  final returnedCount = 0.obs;
  final checkoutCount = 0.obs;

  // ✅ Tổng số phòng trống
  final availableRooms = 0.obs;

  Repositoryhotelindex repositoryhotelindex = GetIt.I<Repositoryhotelindex>();
  late final SharedPreferences prefs;

  @override
  void onInit() async {
    isLoading.value = true;
    prefs = GetIt.I<SharedPreferences>();
    await getAllBookedOfHotel();
    await getDoanhThu();
    await getBookingStatusCount();
    await getAvailableRooms();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getAllBookedOfHotel() async {
    int idUser = await getIdUser();
    bookedHotels.clear();
    bookedHotels.value =
        await repositoryhotelindex.getAllBookedOfHotel(idUser);
  }

  Future<void> getDoanhThu() async {
    int idUser = await getIdUser();
    money.value = await repositoryhotelindex.getDoanhThu(idUser);
    print(money.value);
  }

  Future<void> getBookingStatusCount() async {
    int idUser = await getIdUser();
    final counts = await repositoryhotelindex.getBookingCounts(idUser);

    waitCount.value = counts['WAIT'] ?? 0;
    confirmedCount.value = counts['CONFIRMED'] ?? 0;
    cancelledCount.value = counts['CANCELLED'] ?? 0;
    returnedCount.value = counts['RETURNED'] ?? 0;
    checkoutCount.value = counts['CHECKOUT'] ?? 0;
  }

  Future<void> getAvailableRooms() async {
    int idUser = await getIdUser();
    availableRooms.value =
        await repositoryhotelindex.getAvailableRooms(idUser);
  }

  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }

  /// ✅ Lọc danh sách đặt phòng theo trạng thái
  List<BookHotelModel> getBookingsByStatus(String status) {
    return bookedHotels.where((e) => e.statusBook == status).toList();
  }
}
