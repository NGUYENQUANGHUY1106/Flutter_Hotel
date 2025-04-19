import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceVn {
  String id;
  String name;
  ProvinceVn({
    required this.id,
    required this.name,
  });

  factory ProvinceVn.fromMap(Map<String, dynamic> map) {
    return ProvinceVn(
      id: map['idProvince'] as String,
      name: map['name'] as String,
    );
  }
}

class Districts {
  String idProvince;
  String idDistrict;
  String name;
  Districts({
    required this.idProvince,
    required this.idDistrict,
    required this.name,
  });

  factory Districts.fromMap(Map<String, dynamic> map) {
    return Districts(
      idProvince: map['idProvince'] as String,
      idDistrict: map['idDistrict'] as String,
      name: map['name'] as String,
    );
  }
}

class Town {
  String idDistrict;
  String idCommune;
  String name;
  Town({
    required this.idDistrict,
    required this.idCommune,
    required this.name,
  });

  factory Town.fromMap(Map<String, dynamic> map) {
    return Town(
      idDistrict: map['idDistrict'] as String,
      idCommune: map['idCommune'] as String,
      name: map['name'] as String,
    );
  }
}
