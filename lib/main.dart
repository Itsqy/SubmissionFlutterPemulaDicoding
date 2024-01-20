import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helloflutter/data/api/api_services.dart';
import 'package:helloflutter/data/db/database_helper.dart';
import 'package:helloflutter/data/model/resto_search.dart';
import 'package:helloflutter/provider/alarm_provider.dart';
import 'package:helloflutter/utils/background_service.dart';
import 'package:helloflutter/utils/notification_helper.dart';
import 'package:helloflutter/utils/pref_helper.dart';
import 'package:helloflutter/provider/database_provider.dart';
import 'package:helloflutter/provider/pref_provider.dart';
import 'package:helloflutter/provider/resto_detail_provider.dart';
import 'package:helloflutter/provider/resto_provider.dart';
import 'package:helloflutter/provider/resto_search_provider.dart';
import 'package:http/http.dart' as http;

import 'package:helloflutter/screen/dashboard_screen.dart';
import 'package:helloflutter/screen/detail_screen.dart';
import 'package:helloflutter/screen/favorite_screen.dart';
import 'package:helloflutter/screen/main_screen.dart';
import 'package:helloflutter/screen/search_screen.dart';
import 'package:helloflutter/screen/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  WidgetsFlutterBinding.ensureInitialized();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestoSearchProvider(
              apiService: ApiService(http.Client as http.Client)),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              RestoProvider(apiService: ApiService(http.Client as http.Client)),
        ),
        ChangeNotifierProvider(
          create: (_) => AlarmProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestoDetailProvider(
              apiService: ApiService(http.Client as http.Client)),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PrefHelper(
              sharedPref: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
            title: 'Eauteuy',
            theme: provider.themeData,
            initialRoute: MainScreen.routeName,
            routes: {
              MainScreen.routeName: (context) => const MainScreen(),
              SettingScreen.routeName: (context) => const SettingScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
              FavoriteScreen.routeName: (context) => const FavoriteScreen(),
              DashboardScreen.routeName: (context) => DashboardScreen(
                  // ModalRoute.of(context)?.settings.arguments as String
                  "rifqi"),
              DetailScreen.routeName: (context) => DetailScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
            });
      }),
    );
  }
}
