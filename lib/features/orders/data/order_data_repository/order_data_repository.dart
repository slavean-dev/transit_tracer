import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_errors.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_failure.dart';
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
    } on FirebaseException catch (e) {
      throw FirebaseFailure(null, type: FirebaseAuthErrors.map(e.code));
    }
  }

  Query<Map<String, dynamic>> _getOrdersQuery({
    required String uid,
    required bool isArchive,
  }) {
    return _firebaseFirestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('isArchive', isEqualTo: isArchive)
        .orderBy('createdAt', descending: true);
  }

  @override
  Stream<List<OrderData>> getActiveOrders() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('Unauthenticated');
    final uid = currentUser.uid;
    return _getOrdersQuery(uid: uid, isArchive: false)
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderData.fromFirestore(doc)).toList(),
        )
        .handleError((error) {
          if (error is FirebaseException) {
            throw FirebaseFailure(
              error.message,
              type: FirebaseAuthErrors.map(error.code),
            );
          }
        });
  }

  @override
  Stream<List<OrderData>> getArchivedOrders() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('Unauthenticated');
    final uid = currentUser.uid;
    return _getOrdersQuery(uid: uid, isArchive: true)
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderData.fromFirestore(doc)).toList(),
        )
        .handleError((error) {
          if (error is FirebaseException) {
            throw FirebaseFailure(
              error.message,
              type: FirebaseAuthErrors.map(error.code),
            );
          }
        });
  }

  @override
  Future<void> deleteOrder(String oid) async {
    try {
      await _firebaseFirestore.collection('orders').doc(oid).delete();
    } on FirebaseException catch (e) {
      throw FirebaseFailure(null, type: FirebaseAuthErrors.map(e.code));
    }
  }

  @override
  Stream<OrderData> getOrderById(String oid) {
    return _firebaseFirestore
        .collection('orders')
        .doc(oid)
        .snapshots(includeMetadataChanges: true)
        .map((doc) {
          return OrderData.fromFirestore(doc);
        })
        .handleError((error) {
          if (error is FirebaseException) {
            throw FirebaseFailure(
              error.message,
              type: FirebaseAuthErrors.map(error.code),
            );
          }
        });
  }

  @override
  Future<void> editOrderData(OrderData order) async {
    try {
      await _firebaseFirestore
          .collection('orders')
          .doc(order.oid)
          .update(order.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseFailure(null, type: FirebaseAuthErrors.map(e.code));
    }
  }

  @override
  Future<void> toggleArchiveStatus(
    String oid,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _firebaseFirestore.collection('orders').doc(oid).update(updates);
    } on FirebaseException catch (e) {
      throw FirebaseFailure(null, type: FirebaseAuthErrors.map(e.code));
    }
  }
}
