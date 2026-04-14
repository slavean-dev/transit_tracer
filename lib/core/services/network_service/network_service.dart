import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:transit_tracer/core/services/network_service/abstract_network_service.dart';

class NetworkService implements AbstractNetworkService {
  NetworkService({required InternetConnection checker}) : _checker = checker;
  final InternetConnection _checker;

  @override
  Future<bool> get isConnected => _checker.hasInternetAccess;

  @override
  Stream<InternetStatus> get status => _checker.onStatusChange;
}
