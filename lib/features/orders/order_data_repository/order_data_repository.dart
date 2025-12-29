import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/order_data_repository/abstract_order_repository.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';
import 'package:uuid/uuid.dart';

class OrderDataRepository implements AbstractOrderRepository {
  OrderDataRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<void> saveOrder(
    CityPoint from,
    CityPoint to,
    String discription,
    WeightRange weight,
    String price,
  ) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      final oid = const Uuid().v4();
      if (currentUser == null) throw Exception('Unauthenticated');
      final orderData = OrderData(
        uid: currentUser.uid,
        oid: oid,
        from: from,
        to: to,
        // from: from,
        // fromId: fromId,
        // to: to,
        // toId: toId,
        discription: discription,
        weight: weight,
        price: price,
        isActive: true,
        createdAt: DateTime.now(),
      );
      await _firebaseFirestore
          .collection('orders')
          .doc(oid)
          .set(orderData.toJson());
    } catch (e, s) {
      debugPrint('saveOrder error: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<OrderData>> loadOrders() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('Unauthenticated');
    final uid = currentUser.uid;
    final snapshot = await _firebaseFirestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .get();
    final orders = snapshot.docs
        .map((doc) => OrderData.fromJson(doc.data()))
        .toList();
    return orders;
  }

  @override
  Future<void> deleteOrder(String oid) async {
    try {
      await _firebaseFirestore.collection('orders').doc(oid).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
