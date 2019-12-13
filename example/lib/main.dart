import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> doWork() async {
    bool ret = await FlutterShare.isInstallSms();
    if (ret) {
      FlutterShare.sendSms(phone: "123", text: "aaaaa");
    }
    ret = await FlutterShare.isInstallWhatsApp();
    if (ret) {
      FlutterShare.sendToWhatsApp(text: "哈哈哈 ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
              onPressed: () {
                doWork();
              },
              child: Text('Click Me')),
        ),
      ),
    );
  }
}
