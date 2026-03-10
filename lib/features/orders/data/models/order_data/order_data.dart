import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
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
      FirebaseConstants.oid: oid,
      FirebaseConstants.uid: uid,
      FirebaseConstants.from: from.toJson(),
      FirebaseConstants.to: to.toJson(),
      FirebaseConstants.description: description,
      FirebaseConstants.weight: weight.name,
      FirebaseConstants.price: price,
      FirebaseConstants.createdAt: createdAt.toIso8601String(),
      FirebaseConstants.isArchive: isArchive,
      FirebaseConstants.status: status.name,
    };
  }

  factory OrderData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return OrderData(
      uid: data[FirebaseConstants.uid] as String? ?? '',
      oid: data[FirebaseConstants.oid] as String? ?? '',
      from: CityPoint.fromJson(
        data[FirebaseConstants.from] as Map<String, dynamic>? ?? {},
      ),
      to: CityPoint.fromJson(
        data[FirebaseConstants.to] as Map<String, dynamic>? ?? {},
      ),
      description: data[FirebaseConstants.description] as String? ?? '',
      weight: WeightRange.values.firstWhere(
        (e) => e.name == data[FirebaseConstants.weight],
        orElse: () => WeightRange.upTo500,
      ),
      price: data[FirebaseConstants.price] as String? ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data[FirebaseConstants.status],
        orElse: () => OrderStatus.active,
      ),
      createdAt: data[FirebaseConstants.isArchive] != null
          ? DateTime.tryParse(data[FirebaseConstants.createdAt] as String) ??
                DateTime.now()
          : DateTime.now(),
      isArchive: data[FirebaseConstants.isArchive] as bool? ?? false,
      isPending: doc.metadata.hasPendingWrites,
    );
  }
}
