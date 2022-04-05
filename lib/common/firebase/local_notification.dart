import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../module/notification/view/notifications.dart';

abstract class LocalNotificationService {
  const LocalNotificationService();

  static final _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initial(BuildContext context) {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationPlugin.initialize(
      initializationSettings,
      onSelectNotification: (route) async {
        await AppRoutes.push(context, const NotificationsView());
        return;
      },
    );
  }

  static String _title(RemoteMessage message) {
    try {
      return message?.notification?.title ??
          message?.data['title'] as String ??
          '';
    } catch (e) {
      log('Exception in LocalNotificationService._title : $e');
      return '';
    }
  }

  static String _body(RemoteMessage message) {
    try {
      return message?.notification?.title ??
          message?.data['body'] as String ??
          '';
    } catch (e) {
      log('Exception in LocalNotificationService._title : $e');
      return '';
    }
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      await _notificationPlugin.show(
        _notificationId,
        _title(message),
        _body(message),
        _notificationDetails,
        payload: 'route_name',
      );
    } catch (e) {
      log('Exception in LocalNotificationService.display : $e');
    }
  }

  static int get _notificationId {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static NotificationDetails get _notificationDetails {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'shehabtest',
        'shehabtest channel',
        'ios channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
}
