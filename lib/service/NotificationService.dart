import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final NotificationService _instance = NotificationService._internal();

  NotificationService._internal();

  static NotificationService get instance => _instance;
  
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future initNotification() async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.cancelAll();
    AndroidInitializationSettings androidInitializeSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializeSetting = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false  
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializeSetting,
      iOS: iosInitializeSetting
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showScheduleNotification(int notification_id, String title, String subTitle, String drawnDate, int afterDate) async {
    var androidDetails = const AndroidNotificationDetails(
      'your_unique_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      color: Color.fromARGB(255, 255, 0, 0),
    );

    var iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification_id,
      title,
      subTitle + ' ('+drawnDate.tr()+')',
      _timeZoneSetting(day: afterDate),
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _timeZoneSetting({
      required int day,
    }) {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.local);
      tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate;
      scheduledDate =
          tz.TZDateTime(tz.local, _now.year, _now.month, _now.day + day, _now.hour, _now.minute);
      return scheduledDate;
    }

  Future requestNotificationPermission() async {
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    }
    else {
      await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  void showAllNotifications(Map<String, dynamic> jackpots) {
    if (jackpots["USPowerball"] != null) {
      showScheduleNotification(1, "tryUSPowerball".tr() + " (" + "usa".tr() + ")", "winJackpot".tr() + jackpots["USPowerball"], "americanLotteryInfo.drawDate".tr(), 1);
    }
    if (jackpots["MegaMillion"] != null) {
      showScheduleNotification(2, "tryMegaMillion".tr() + " (" + "usa".tr() + ")", "winJackpot".tr() + jackpots["MegaMillion"], "megaMillionsInfo.drawDate".tr(), 1);
    }
    if (jackpots["EuroJackpot"] != null) {
      showScheduleNotification(3, "tryEuroJackpot".tr() + " (" + "eu".tr() + ")", "winJackpot".tr() + jackpots["EuroJackpot"], "euroJackpotInfo.drawDate".tr(), 3);
    }
    if (jackpots["EuroMillion"] != null) {
      showScheduleNotification(4, "tryEuroMillion".tr() + " (" + "eu".tr() + ")", "winJackpot".tr() + jackpots["EuroMillion"], "euroMillionsInfo.drawDate".tr(), 3);
    }
    if (jackpots["Elgordo"] != null) {
      showScheduleNotification(5, "tryElgordo".tr() + " (" + "spain".tr() + ")", "winJackpot".tr() + jackpots["Elgordo"], "elGordoLotteryInfo.drawDate".tr(), 4);
    }
    if (jackpots["LaPrimitiva"] != null) {
      showScheduleNotification(6, "tryLaPrimitiva".tr() + " (" + "spain".tr() + ")", "winJackpot".tr() + jackpots["LaPrimitiva"], "spanishLaPrimitivaInfo.drawDate".tr(), 4);
    }
    if (jackpots["SuperEnalotto"] != null) { 
      showScheduleNotification(7, "trySuperEnalotto".tr() + " (" + "italy".tr() + ")", "winJackpot".tr() + jackpots["SuperEnalotto"], "superEnalottoInfo.drawDate".tr(), 5);
    }
    if (jackpots["UKLotto"] != null) {
      showScheduleNotification(8, "tryUKLotto".tr() + " (" + "uk".tr() + ")", "winJackpot".tr() + jackpots["UKLotto"], "ukLottoInfo.drawDate".tr(), 5);
    }
    if (jackpots["AusPowerball"] != null) {
      showScheduleNotification(9, "tryAusPowerball".tr() + " (" + "aus".tr() + ")", "winJackpot".tr() + jackpots["AusPowerball"], "australiaPowerballInfo.drawDate".tr(), 6);
    }
  }
}