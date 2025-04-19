import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/data/domain/EndpointCustomer.dart';
import 'package:dio/dio.dart';

class Repositorydetailhotel {
  final Dio dio;
  Repositorydetailhotel({required this.dio});

  Future<void> bookHotel({
    required RequestBookHotelModel data,
    required Function() success,
    required Function() e,
  }) async {
    print(data.toJson());
    Response response =
        await dio.post(Endpointcustomer.bookHotel, data: data.toJson());
    if (response.statusCode == 200) {
      success();
    } else {
      e();
    }
  }
}
