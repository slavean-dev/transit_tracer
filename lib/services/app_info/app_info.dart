import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static late final String version;

  Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    version = info.version;
  }
}
