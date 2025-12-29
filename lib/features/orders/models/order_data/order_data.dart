import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';

class OrderData {
  OrderData({
    required this.from,
    required this.to,
    required this.uid,
    required this.oid,
    // required this.from,
    // required this.fromId,
    // required this.to,
    // required this.toId,
    required this.discription,
    required this.weight,
    required this.price,
    required this.isActive,
    required this.createdAt,
  });
  final CityPoint from;
  final CityPoint to;
  // final String from;
  // final String fromId;
  // final String to;
  // final String toId;
  final String discription;
  final WeightRange weight;
  final String price;
  final String uid;
  final String oid;
  final bool isActive;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'oid': oid,
      'uid': uid,
      'from': from.toJson(),
      'to': to.toJson(),
      // 'frome': from,
      // 'fromId': fromId,
      // 'to': to,
      // 'toId': toId,
      'discription': discription,
      'weight': weight.name,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      uid: json['uid'] as String,
      oid: json['oid'] as String,
      from: CityPoint.fromJson(json['from'] as Map<String, dynamic>),
      to: CityPoint.fromJson(json['to'] as Map<String, dynamic>),
      // from: map['frome'] as String,
      // fromId: map['fromId'] as String,
      // to: map['to'] as String,
      // toId: map['toId'] as String,
      discription: json['discription'] as String,
      weight: WeightRange.values.byName(json['weight']),
      price: json['price'] as String,
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
