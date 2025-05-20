import 'dart:convert';

class RequestBookHotelModel {
  final int? id;               
  final int? idHotel;          
  final int? idUser;            
  final int totalPrice;        
  final int countRoom;          
  final DateTime bookStart;     
  final DateTime bookEnd;       
  final String? checkinTime;    
  final String? checkoutTime;   

  RequestBookHotelModel({
    this.id,
    this.idHotel,
    this.idUser,
    required this.totalPrice,
    required this.countRoom,
    required this.bookStart,
    required this.bookEnd,
    this.checkinTime,
    this.checkoutTime,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (idHotel != null) 'idHotel': idHotel,
      if (idUser != null) 'idUser': idUser,
      'totalPrice': totalPrice,
      'countRoom': countRoom,
      'bookStart': bookStart.millisecondsSinceEpoch,
      'bookEnd': bookEnd.millisecondsSinceEpoch,
      'checkinTime': checkinTime,
      'checkoutTime': checkoutTime,
    };
  }

  String toJson() => json.encode(toMap());
}
