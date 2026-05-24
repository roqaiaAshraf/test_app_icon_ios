import 'dart:developer';

import 'package:flutter/services.dart';

class DynamicIconService {
  DynamicIconService._();
  static const _channel = MethodChannel('dynamic_icon');
  static Future<String> getCurrentIcon() async {
    try {
      final name = await _channel.invokeMethod<String>('getIcon');
      //default
      return name ?? 'DefaultIcon';
    } on PlatformException catch (e) {
      log('Failed to get current icon: ${e.message}');
      return 'DayIcon';
    }
  }

  static Future<void> setIcon({required String iconName}) async {
    try {
      await _channel.invokeMethod('setIcon', {'icon': iconName});
    } on PlatformException catch (e) {
      log('Failed to set  icon: ${e.message}');
      rethrow;
    }
  }
}
