import 'dart:convert';
import 'package:book_hotel/Model/HotelModel.dart';

class BookHotelModel {
  final int? id;
  final DateTime? bookStart;
  final DateTime? bookEnd;
  final String? statusBook;
  final int? totalPrice;
  final int? countRoom;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? modifiedBy;
  final HotelModel? hotel;

  BookHotelModel({
    this.id,
    this.bookStart,
    this.bookEnd,
    this.statusBook,
    this.totalPrice,
    this.countRoom,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.modifiedBy,
    this.hotel,
  });

  factory BookHotelModel.fromMap(Map<String, dynamic> map) {
    return BookHotelModel(
      id: map['id'] as int?,
      bookStart: map['bookStart'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['bookStart'])
          : null,
      bookEnd: map['bookEnd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['bookEnd'])
          : null,
      statusBook: map['statusBook'] as String?,
      totalPrice: map['totalPrice'] as int?,
      countRoom: map['countRoom'] as int?,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      createdBy: map['createdBy'] as String?,
      modifiedBy: map['modifiedBy'] as String?,
      hotel: map['hotel'] != null
          ? HotelModel.fromMap(map['hotel'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (bookStart != null) 'bookStart': bookStart!.millisecondsSinceEpoch,
      if (bookEnd != null) 'bookEnd': bookEnd!.millisecondsSinceEpoch,
      if (statusBook != null) 'statusBook': statusBook,
      if (totalPrice != null) 'totalPrice': totalPrice,
      if (countRoom != null) 'countRoom': countRoom,
      if (createdAt != null) 'createdAt': createdAt!.millisecondsSinceEpoch,
      if (updatedAt != null) 'updatedAt': updatedAt!.millisecondsSinceEpoch,
      if (createdBy != null) 'createdBy': createdBy,
      if (modifiedBy != null) 'modifiedBy': modifiedBy,
      if (hotel != null) 'hotel': hotel!.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory BookHotelModel.fromJson(String source) =>
      BookHotelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookHotelModel(id: $id, bookStart: $bookStart, bookEnd: $bookEnd, statusBook: $statusBook, totalPrice: $totalPrice, countRoom: $countRoom, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, modifiedBy: $modifiedBy, hotel: $hotel)';
  }
}
