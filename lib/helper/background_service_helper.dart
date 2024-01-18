import 'dart:ui';
import 'dart:isolate';

import 'package:flutter/material.dart';

import '../service/api_services.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    try {
      var randomRestaurant = await ApiService().getRandomRestaurant();
      debugPrint('Random Restaurant Data: $randomRestaurant');

      await notificationHelper.showNotification(
        randomRestaurant,
      );
    } catch (e) {
      debugPrint('Error in callback: $e');
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
