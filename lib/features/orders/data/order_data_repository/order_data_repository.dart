import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
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
    String description,
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
        description: description,
        weight: weight,
        price: price,
        status: OrderStatus.active,
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

  Query<Map<String, dynamic>> _getOrdersQuery({
    required String uid,
    required List<String> status,
  }) {
    return _firebaseFirestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('status', whereIn: status)
        .orderBy('createdAt', descending: true);
  }

  @override
  Stream<List<OrderData>> getActiveOrders() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('Unauthenticated');
    final uid = currentUser.uid;
    return _getOrdersQuery(
          uid: uid,
          status: ['active', 'inProgress', 'completed'],
        )
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderData.fromFirestore(doc)).toList(),
        );
  }

  @override
  Stream<List<OrderData>> getArchivedOrders() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('Unauthenticated');
    final uid = currentUser.uid;
    return _getOrdersQuery(uid: uid, status: ['archived', 'completed'])
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderData.fromFirestore(doc)).toList(),
        );
  }

  @override
  Future<void> deleteOrder(String oid) async {
    try {
      await _firebaseFirestore.collection('orders').doc(oid).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<OrderData> getOrderById(String oid) {
    try {
      return _firebaseFirestore
          .collection('orders')
          .doc(oid)
          .snapshots(includeMetadataChanges: true)
          .map((doc) => OrderData.fromFirestore(doc));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editOrderData(OrderData order) async {
    try {
      await _firebaseFirestore
          .collection('orders')
          .doc(order.oid)
          .update(order.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> archiveOrder(String oid) async {
    try {
      await _firebaseFirestore.collection('orders').doc(oid).update({
        'status': OrderStatus.archived.name,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
