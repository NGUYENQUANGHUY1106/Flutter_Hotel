import 'package:book_hotel/Model/UserModel.dart';

import 'dart:convert';

class CustomerModel {
  UserModel? user;
  String? username;
  String? phone;

  CustomerModel({
    this.user,
    this.username,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (user != null) 'user': user!.toMap(),
      if (username != null) 'username': username,
      if (phone != null) 'phone': phone,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CustomerModel(user: $user, username: $username, phone: $phone)';
}
