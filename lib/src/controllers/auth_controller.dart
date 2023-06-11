import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/models/User.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:griyatilawah_absesnsi/src/services/api_services.dart';

class AuthController extends GetxController {
  // Membuat variabel untuk password visibility
  RxBool passwordVisibility = false.obs;

  // Membuat variable form key
  final formKeylogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  // Membuat controller
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerName = TextEditingController();

  final ApiService _apiService = ApiService();

  RxString email = ''.obs;
  RxString password = ''.obs;

  // buat variable global untuk menyimpan token
  RxString token1 = ''.obs;

  Future<void> login() async {
    try {
      final response = await _apiService.login(
          controllerUsername.text, controllerPassword.text);

      // Response handling
      if (response.containsKey('status') && response['status'] == true) {
        final token = response['token'];
        token1.value = token;
        final userData = response['data'];
        // Simpan token dan data pengguna di sini
        // Redirect ke halaman setelah login berhasil
        // redirect ke halaman home dan kirim data pengguna menggunakan argumen
        Get.offAll(() => HomePage(), arguments: userData);
      } else {
        final message = response['message'];
        // Tampilkan pesan kesalahan jika login gagal
        Get.snackbar('Login Gagal', message);
      }
    } catch (e) {
      // Tangani kesalahan saat melakukan permintaan HTTP
      Get.snackbar('Error', 'Terjadi kesalahan saat melakukan login.');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
