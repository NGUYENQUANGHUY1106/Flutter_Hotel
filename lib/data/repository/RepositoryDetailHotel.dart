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
  try {
    print("⏳ Đang gửi data: ${data.toJson()}"); //  In dữ liệu trước khi gửi

    Response response = await dio.post(
      Endpointcustomer.bookHotel,
      data: data.toJson(),
    );

    print(" STATUS: ${response.statusCode}");
    print(" RESPONSE: ${response.data}");

    if (response.statusCode == 200) {
      success();
    } else {
      e();
    }
  } catch (error) {
    if (error is DioException) {
      print(" DIO ERROR: ${error.response?.statusCode} - ${error.response?.data}");
    } else {
      print(" UNKNOWN ERROR: $error");
    }
    e();
  }
}

}
