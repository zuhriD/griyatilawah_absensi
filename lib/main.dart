import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:griyatilawah_absesnsi/src/services/api_services.dart';
import 'package:griyatilawah_absesnsi/src/services/notifi_service.dart';
import 'package:griyatilawah_absesnsi/src/services/workmanager_services.dart';
import 'package:griyatilawah_absesnsi/src/views/auth/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import timezone
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  registerNotification();
  tz.initializeTimeZones();
  // periksa apakah sudah login atau belum
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final username = prefs.getString('username');
  final password = prefs.getString('password');

  FlutterNativeSplash(); //
  if (token != null && username != null) {
    print('sudah login');
  } else {
    print('belum login');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Griya Tilawah Absensi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
