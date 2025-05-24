import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/data/domain/EndpointCustomer.dart';
import 'package:dio/dio.dart';

class Repositoryhotelindex {
  final Dio dio;
  Repositoryhotelindex({required this.dio});

  Future<List<BookHotelModel>> getAllBookedOfHotel(int idUser) async {
    Response response =
        await dio.get("${Endpointcustomer.getAllBookHotelByIdUser}/$idUser");
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data
          .map(
            (e) => BookHotelModel.fromMap(e),
          )
          .toList();
    }
    return [];
  }
     Future<double> getDoanhThu(int idUser) async {
     Response response =
         await dio.get("${Endpointcustomer.getDoanhThu}/$idUser");
     if (response.statusCode == 200) {
       return response.data as double;
     }
     return 0.0;
   }
  Future<int> getAvailableRooms(int idUser) async {
    try {
      final response =
          await dio.get("${Endpointcustomer.getAvailableRoomByUserId}/$idUser");
      if (response.statusCode == 200) {
        return response.data as int;
      }
    } catch (e) {
      print("Lỗi getAvailableRooms: $e");
    }
    return 0;
  }
  Future<Map<String, int>> getBookingCounts(int idUser) async {
    try {
      final response =
          await dio.get("${Endpointcustomer.getBookingStatusCount}/$idUser");
      if (response.statusCode == 200) {
        return Map<String, int>.from(response.data);
      }
    } catch (e) {
      print("Lỗi getBookingCounts: $e");
    }
    return {};
  }
}
 


