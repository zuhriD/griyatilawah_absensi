import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/views/login.dart';

class HomeController extends GetxController {
  final name = Get.arguments;

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
  }

  void changeTab(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
