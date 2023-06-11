import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/controllers/auth_controller.dart';
import 'package:griyatilawah_absesnsi/src/views/auth/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:griyatilawah_absesnsi/src/models/Jadwal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  final userdata = Get.arguments;

  var authcontroller = Get.find<AuthController>();

  var jadwalList = <Jadwal>[].obs;

  // final Absensi data = Get.arguments;
  var formBox;
  var authBox = Hive.box('auth');

  List<dynamic> listJadwal = Hive.box('form').values.toList();
  List<dynamic> listKey = Hive.box('form').keys.toList();

  RxBool isLoading = false.obs;

  void showProgressIndicator() {
    isLoading.value = true;
  }

  void hideProgressIndicator() {
    isLoading.value = false;
  }

  void openBox() async {
    formBox = await Hive.openBox('form');
  }

  //make function for logout
  void logout() {
    Get.offAll(() => LoginPage());
  }

  var currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
    print(userdata['id']);
    fetchJadwalList();
  }

  void changeTab(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  //function tanggal
  String tanggal(String date1) {
    // convert string to date
    DateTime date = DateTime.parse(date1);
    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      return 'Hari ini';
    } else if (date.day == DateTime.now().day + 1 &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      return 'Besok';
    } else {
      return DateFormat('dd MMMM yyyy').format(date);
    }
  }

  Future<void> fetchJadwalList() async {
    try {
      final token = authcontroller.token1.value;
      final id = userdata['id'];
      final response = await http.get(
        Uri.parse('http://192.168.1.7:8001/api/jadwal/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        jadwalList.value =
            List<Jadwal>.from(jsonData['data'].map((x) => Jadwal.fromJson(x)));
      } else {
        // Handle error cases
        print('error');
      }
    } catch (e) {
      // Handle exception
      print(e);
    }
  }
}
