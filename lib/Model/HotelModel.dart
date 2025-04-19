import 'dart:convert';
import 'UserModel.dart';
import 'AddressModel.dart';

class HotelModel {
  int? id;
  String? username;
  UserModel? user;
  AddressModel? address;
  String? img;
  int? price;

  HotelModel(
      {this.id, this.username, this.user, this.address, this.img, this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (user != null) 'user': user!.toMap(),
      if (address != null) 'address': address!.toMap(),
      if (img != null) 'img': img,
      if (price != null) 'price': price,
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      img: map['img'] != null ? map['img'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'HotelModel(id: $id, username: $username, user: $user, address: $address, img: $img ,price: $price)';
  }

  factory HotelModel.fromJson(String source) =>
      HotelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
