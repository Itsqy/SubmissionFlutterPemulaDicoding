import 'package:flutter/material.dart';
import 'package:helloflutter/data/model/resto_responses.dart';

import 'package:helloflutter/screen/dashboard_screen.dart';
import 'package:helloflutter/screen/detail_screen.dart';
import 'package:helloflutter/screen/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(
              ModalRoute.of(context)?.settings.arguments as String),
          DetailScreen.routeName: (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
        });
  }
}
