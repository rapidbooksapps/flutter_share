import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterShare {
  static const MethodChannel _channel = const MethodChannel('flutter_share');

  static Future<bool> isInstallWhatsApp() async {
    bool ret = await _channel.invokeMethod('isInstallWhatsApp');
    return ret;
  }

  static Future<bool> isInstallSms() async {
    bool ret = await _channel.invokeMethod('isInstallSms');
    return ret;
  }

  static Future<bool> sendSms(
      {@required String phone, @required String text}) async {
    var data = Map<String, String>();
    data['phone'] = phone;
    data['text'] = text;
    bool ret = await _channel.invokeMethod('sendSms', data);
    return ret;
  }

  static Future<bool> sendToWhatsApp({@required String text}) async {
    var data = Map<String, String>();
    data['text'] = text;
    bool ret = await _channel.invokeMethod('sendToWhatsApp', data);
    return ret;
  }
}
