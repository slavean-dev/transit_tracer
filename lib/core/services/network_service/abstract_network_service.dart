import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class AbstractNetworkService {
  Future<bool> get isConnected;
  Stream<InternetStatus> get status;
}
