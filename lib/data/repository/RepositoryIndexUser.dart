import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/CustomerModel.dart';
import 'package:book_hotel/Model/HotelModel.dart';
import 'package:book_hotel/Model/ProvinceVn.dart';
import 'package:book_hotel/data/domain/EndpointCustomer.dart';
import 'package:book_hotel/data/domain/EndpointHotel.dart';
import 'package:dio/dio.dart';

class Repositoryindexuser {
  final Dio dio;

  Repositoryindexuser({
    required this.dio,
  });

  Future<List<HotelModel>> getAllHotel() async {
    try {
      Response response = await dio.get(Endpointhotel.getAllHotel);

      // Ép kiểu rõ ràng để tránh lỗi
      List<dynamic> data = response.data;

      // Map từng phần tử thành HotelModel
      return data.map((json) => HotelModel.fromMap(json)).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
    Future<CustomerModel?> getCustomer(int idUser) async {
     Response response =
         await dio.get("${Endpointcustomer.getCustomer}/$idUser");
     if (response.statusCode == 200) {
       return CustomerModel.fromMap(response.data);
     }
     return null;
   }

  Future<List<HotelModel>> searchHotel(
      ProvinceVn? province, String nameHotel) async {
    try {
      Map<String, dynamic> dataSend = {
        "province": province?.name,
        "nameHotel": nameHotel
      };
      Response response =
          await dio.post(Endpointcustomer.searchhotel, data: dataSend);
      List<dynamic> data = response.data;
      return data.map((json) => HotelModel.fromMap(json)).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<BookHotelModel>> getAllBookedhotel(int idUser) async {
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
}
