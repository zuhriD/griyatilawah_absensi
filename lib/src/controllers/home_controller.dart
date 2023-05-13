import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/views/auth/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final email = Get.arguments;

  // final Absensi data = Get.arguments;
  var formBox;
  var authBox = Hive.box('auth');
  var name = "";

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
    // var nama = authBox.get(name + 'nama');
    name = authBox.get(email + 'name');
    print(name);
    openBox();
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
  String tanggal(DateTime date) {
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
}
