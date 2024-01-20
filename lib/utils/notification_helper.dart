import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helloflutter/data/model/resto_responses.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();
// final didReceiveLocalNotificationSubject = BehaviorSubject<Received>()

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('logo_eateuy');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  Future<void> showNotif(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestoResponses restoResponses) async {
    const channelId = '3';
    const channelName = 'channel_03';
    const channelDesc = 'recomendation resto app';

    const androidPlatformChannelsSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelsSpecifics);

    const titleNotif = "<b>Rekomendasi restoran hari ini</b>";

    int getRandomRestaurantIndex() {
      final random = Random();
      return random.nextInt(restoResponses.restaurants.length);
    }

    final randomIndex = getRandomRestaurantIndex();
    final resto = restoResponses.restaurants[randomIndex];
    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotif,
      resto.name,
      platformChannelSpecifics,
      payload: json.encode(resto.toJson()),
    );
  }

  void configurationSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((event) {
      var restoData = Restaurant.fromJson(json.decode(event));
      Navigation.intentWithData(route, restoData);
    });
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}
