import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/data/models/weight_range/weight_range.dart';

class OrderData {
  OrderData({
    required this.from,
    required this.to,
    required this.uid,
    required this.oid,
    required this.description,
    required this.weight,
    required this.price,
    required this.status,
    required this.createdAt,
    this.isPending = false,
  });
  final CityPoint from;
  final CityPoint to;
  final String description;
  final WeightRange weight;
  final String price;
  final String uid;
  final String oid;
  final OrderStatus status;
  final DateTime createdAt;
  final bool isPending;

  Map<String, dynamic> toJson() {
    return {
      'oid': oid,
      'uid': uid,
      'from': from.toJson(),
      'to': to.toJson(),
      'description': description,
      'weight': weight.name,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  factory OrderData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return OrderData(
      uid: data['uid'] as String,
      oid: data['oid'] as String,
      from: CityPoint.fromJson(data['from'] as Map<String, dynamic>),
      to: CityPoint.fromJson(data['to'] as Map<String, dynamic>),
      description: data['description'] as String,
      weight: WeightRange.values.byName(data['weight']),
      price: data['price'] as String,
      status: OrderStatus.values.byName(data['status']),
      createdAt: DateTime.parse(data['createdAt'] as String),
      isPending: doc.metadata.hasPendingWrites,
    );
  }

  // factory OrderData.fromJson(Map<String, dynamic> json) {
  //   return OrderData(
  //     uid: json['uid'] as String,
  //     oid: json['oid'] as String,
  //     from: CityPoint.fromJson(json['from'] as Map<String, dynamic>),
  //     to: CityPoint.fromJson(json['to'] as Map<String, dynamic>),
  //     description: json['description'] as String,
  //     weight: WeightRange.values.byName(json['weight']),
  //     price: json['price'] as String,
  //     status: OrderStatus.values.byName(json['status']),
  //     createdAt: DateTime.parse(json['createdAt'] as String),
  //     isPending:
  //   );
  // }
}
