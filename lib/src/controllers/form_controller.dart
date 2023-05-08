import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage.dart';
import 'package:griyatilawah_absesnsi/src/views/listview_absensi.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FormController extends GetxController {
  final controllerNama = TextEditingController();
  final controllerMasjid = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerSholat = TextEditingController();
  final controllerKeterangan = TextEditingController();

  //form box
  final formBox = Hive.box('form');
  var controllerHome = Get.put(HomeController());

  // Fungsi untuk membuka box
  void openBox() async {
    await Hive.openBox('form');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openBox();
    refreshItems();
  }

  var selectedDate = DateTime.now().obs;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Define your own primary color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  // Dropdown Masjid
  var selectedValueMasjid = 'Darussalam'.obs;
  var dropdownValuesMasjid = [
    'Darussalam',
    'Abdullah',
    'An-Nur BMW',
    'Mujahidin',
    'Birrul Walidain',
    'Muslimun'
  ].obs;

  void onDropdownValueMasjidChanged(String? value) {
    if (value != null) {
      selectedValueMasjid.value = value;
    }
  }

  // Dropdown Sholat
  var selectedValueSholat = 'Imam Subuh'.obs;
  var dropdownValuesSholat = [
    'Imam Subuh',
    'Imam Maghrib - Isya',
    'Imam Jumat',
    'Khutbah Jumat',
  ].obs;

  void onDropdownValueSholatChanged(String? value) {
    if (value != null) {
      selectedValueSholat.value = value;
    }
  }

  List<Map<String, dynamic>> items = [];

  void refreshItems() {
    final data = formBox.keys.map((key) {
      final item = formBox.get(key);
      return {
        "key": key,
        "nama": item['nama'],
        "masjid": item['masjid'],
        "tanggal": item['tanggal'],
        "sholat": item['sholat'],
        "keterangan": item['keterangan'],
        "status": item['status'],
      };
    }).toList();

    items = data.reversed.toList();
    print(items.length);
  }

  //create item
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await formBox.add(newItem);
    refreshItems();
    Get.snackbar(
      'Berhasil',
      'Data berhasil disimpan',
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
    );
    Get.offAll(() => HomePage());
  }
}
