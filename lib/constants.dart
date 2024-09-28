import 'dart:async';
import 'package:flutter/services.dart';

class AndroidIdHelper {
  static const MethodChannel _channel = MethodChannel('android_id_helper');

  static Future<String?> getAndroidId() async {
    final String? androidId = await _channel.invokeMethod('getAndroidId');
    return androidId;
  }
}
