import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/models/User.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthController extends GetxController {
  // Membuat variabel untuk password visibility
  RxBool passwordVisibility = false.obs;

  // Membuat variabel untuk user
  User user = User(name: '', email: '', password: '');

  // Membuat variable form key
  final formKey = GlobalKey<FormState>();

  // Membuat controller
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerName = TextEditingController();

  // Membuat box
  final authBox = Hive.box('auth');

  // Fungsi untuk membuka box
  void openBox() async {
    await Hive.openBox('auth');
  }

  // Fungsi untuk login
  Future<void> login() async {
    if (authBox.containsKey(controllerEmail.text) &&
        authBox.containsKey(controllerPassword.text)) {
      //how to get data from hive
      user = User(
          name: authBox.get('${controllerEmail.text}name'),
          email: controllerEmail.text,
          password: controllerPassword.text);
      if (user.password == controllerPassword.text) {
        Get.snackbar('Berhasil', 'Login berhasil');
        Get.offAll(() => HomePage(), arguments: user.name.toString());
      } else {
        Get.snackbar('Gagal', 'Password salah');
      }
    } else {
      Get.snackbar('Gagal', 'Email tidak terdaftar');
    }
  }

  // Fungsi untuk register
  Future<void> register() async {
    if (!authBox.containsKey(controllerEmail.text) &&
        !authBox.containsKey(controllerPassword.text)) {
      //how to save data to hive
      user = User(
          name: controllerName.text,
          email: controllerEmail.text,
          password: controllerPassword.text);
      authBox.put(user.email, user.name);
      authBox.put('${user.email}name', user.name);
      authBox.put(user.password, user.password);
      Get.snackbar('Berhasil', 'Akun berhasil dibuat');
      Get.offAll(() => HomePage(), arguments: user.name.toString());
    } else {
      Get.snackbar('Gagal', 'Email sudah terdaftar');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openBox();
  }
}
