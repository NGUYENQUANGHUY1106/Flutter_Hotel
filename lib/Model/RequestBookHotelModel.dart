import 'dart:convert';

class RequestBookHotelModel {
  final int? id;
  final int? idHotel;
  final int? idUser;
  final int totalPrice;
  final int countRoom;
  final DateTime bookStart;
  final DateTime bookEnd;

  RequestBookHotelModel({
    this.id,
    this.idHotel,
    this.idUser,
    required this.totalPrice,
    required this.countRoom,
    required this.bookStart,
    required this.bookEnd,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idHotel': idHotel,
      'idUser': idUser,
      'totalPrice': totalPrice,
      'countRoom': countRoom,
      'bookStart': bookStart.toIso8601String(),
      'bookEnd': bookEnd.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
