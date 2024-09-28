import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hesham_tarek/constants.dart';

class Functions {
  static Future<String> getDeviceIdentifiers() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      String? androidId = await AndroidIdHelper.getAndroidId();
      return androidId ?? "";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final identifierForVendor = iosInfo.identifierForVendor;
      return identifierForVendor ?? "";
    } else {
      return "";
    }
  }
}
