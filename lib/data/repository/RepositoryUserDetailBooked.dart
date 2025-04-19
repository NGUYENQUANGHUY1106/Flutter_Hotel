import 'package:book_hotel/Model/BookHotelModel.dart';
import 'package:book_hotel/Model/RateModel.dart';
import 'package:book_hotel/Model/RequestBookHotelModel.dart';
import 'package:book_hotel/Model/RequestRateModel.dart';
import 'package:book_hotel/core/util/UtilConst.dart';
import 'package:book_hotel/data/domain/EndpointCustomer.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repositoryuserdetailbooked {
  final Dio dio;
  final SharedPreferences sharedPreferences;


  Repositoryuserdetailbooked(
       {required this.dio, required this.sharedPreferences});

  Future<void> updateStatusBooked(int idBooked, String status,
      {required Function(BookHotelModel data) success,
      required Function() e}) async {
    Response response = await dio
        .put("${Endpointcustomer.updateStatusBooked}/$idBooked/$status");
    if (response.statusCode == 200) {
      final data = BookHotelModel.fromMap(response.data);
      success(data);
    } else {
      e();
    }
  }

  Future<void> updateBookedHotel(
      {required Function(BookHotelModel data) success,
      required RequestBookHotelModel data,
      required Function() e}) async {
    print(data.toJson());
    Response response =
        await dio.put(Endpointcustomer.updateStatusBooked, data: data.toJson());
    if (response.statusCode == 200) {
      final data = BookHotelModel.fromMap(response.data);
      success(data);
    } else {
      e();
    }
  }
  Future<void> addRate(
       {required Function() success,
       required Requestaddrate data,
       required Function() e}) async {
     int idUser = await sharedPreferences.getInt(UtilConst.idUser)!;
     data.idUser = idUser;
     Response response =
         await dio.post(Endpointcustomer.addRate, data: data.toJson());
     if (response.statusCode == 200) {
       success();
     } else {
       e();
     }
   }
 
   Future<void> getAllRate(
       {required Function(List<Ratemodel>) success,
       required int idHotel,
       required Function() e}) async {
     Response response =
         await dio.get("${Endpointcustomer.getAllRate}/$idHotel");
     if (response.statusCode == 200) {
       List<Ratemodel> rateList =
           (response.data as List).map((e) => Ratemodel.fromMap(e)).toList();
       print(rateList);
       success(rateList);
     } else {
       e();
     }
   }
}
