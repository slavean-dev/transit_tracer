import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  NetworkService({required InternetConnection checker}) : _checker = checker;
  final InternetConnection _checker;

  Future<bool> get isConnected => _checker.hasInternetAccess;

  // Stream<InternetStatus> get status => _checker.onStatusChange;
}
