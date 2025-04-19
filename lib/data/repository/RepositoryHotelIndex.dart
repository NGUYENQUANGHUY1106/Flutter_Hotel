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
    }
 


