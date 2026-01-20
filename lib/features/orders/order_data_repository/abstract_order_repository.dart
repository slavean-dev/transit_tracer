import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';

abstract class AbstractOrderRepository {
  Future<void> saveOrder(
    CityPoint from,
    CityPoint to,
    String discription,
    WeightRange weight,
    String price,
  );
  Stream<List<OrderData>> getOrders();
  Future<void> deleteOrder(String oid);
}
