import 'dart:convert';
import 'CustomerModel.dart';

class Ratemodel {
  CustomerModel? customer;
  String? comment;
  double? rateStar;
  DateTime? createdAt;

  Ratemodel({
    required this.customer,
    required this.comment,
    required this.rateStar,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (customer != null) 'customer': customer!.toMap(),
      if (comment != null) 'comment': comment,
      if (rateStar != null) 'rateStar': rateStar,
      if (createdAt != null) 'createdAt': createdAt!.millisecondsSinceEpoch,
    };
  }

  factory Ratemodel.fromMap(Map<String, dynamic> map) {
    return Ratemodel(
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'])
          : null,
      comment: map['comment'],
      rateStar:
          map['rateStar'] != null ? (map['rateStar'] as num).toDouble() : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratemodel.fromJson(String source) =>
      Ratemodel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ratemodel(customer: $customer, comment: $comment, rateStar: $rateStar, createdAt: $createdAt)';
  }
}