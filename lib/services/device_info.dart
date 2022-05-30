import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String?> deviceName() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }

    return null;
  }
}
