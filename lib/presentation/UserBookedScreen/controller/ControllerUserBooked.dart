import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/repository/RepositoryIndexUser.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerUserBooked  extends GetxController {
  Repositoryindexuser repositoryindexuser = GetIt.I<Repositoryindexuser>();

  final isLoading = false.obs;
  final format = DateFormat('dd/MM/yyyy');
  late final SharedPreferences prefs;
  final bookedHotels = <BookHotelModel>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    prefs = GetIt.I<SharedPreferences>();
    await getAllBookedHotel();
    isLoading.value = false;
    super.onInit();
  }

Future<void> getAllBookedHotel() async {
  int idUser = await getIdUser();
  bookedHotels.clear();

  final fetchedList = await repositoryindexuser.getAllBookedhotel(idUser);

  fetchedList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

  bookedHotels.value = fetchedList;
}


  Future<int> getIdUser() async {
    return prefs.getInt(UtilConst.idUser)!;
  }
}
