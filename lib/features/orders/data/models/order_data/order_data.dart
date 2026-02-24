import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';

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
    this.isArchive = false,
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
  final bool isArchive;
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
      'isArchive': isArchive,
      'status': status.name,
    };
  }

  factory OrderData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return OrderData(
      uid: data['uid'] as String? ?? '',
      oid: data['oid'] as String? ?? '',
      from: CityPoint.fromJson(data['from'] as Map<String, dynamic>? ?? {}),
      to: CityPoint.fromJson(data['to'] as Map<String, dynamic>? ?? {}),
      description: data['description'] as String? ?? '',
      weight: WeightRange.values.firstWhere(
        (e) => e.name == data['weight'],
        orElse: () => WeightRange.upTo500,
      ),
      price: data['price'] as String? ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => OrderStatus.active,
      ),
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      isArchive: data['isArchive'] as bool? ?? false,
      isPending: doc.metadata.hasPendingWrites,
    );
  }
}
