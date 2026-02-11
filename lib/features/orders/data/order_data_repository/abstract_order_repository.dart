import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';

abstract class AbstractOrderRepository {
  Future<void> saveOrder(
    CityPoint from,
    CityPoint to,
    String description,
    WeightRange weight,
    String price,
  );
  Stream<List<OrderData>> getActiveOrders();
  Stream<List<OrderData>> getArchivedOrders();
  Future<void> deleteOrder(String oid);
  Stream<OrderData> getOrderById(String oid);
  Future<void> editOrderData(OrderData order);
  Future<void> archiveOrder(String oid);
}
