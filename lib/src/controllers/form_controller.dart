import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/homepage.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/listview_absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/osm.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FormController extends GetxController {
  final controllerNama = TextEditingController();
  final controllerMasjid = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerSholat = TextEditingController();
  final controllerKeterangan = TextEditingController();

  var valueLocation = ''.obs;

  final homeController = Get.find<HomeController>();

  late Absensi absensi;

  //form box
  final formBox = Hive.box('form');
  final authBox = Hive.box('auth');

  // Fungsi untuk membuka box
  void openBox() async {
    await Hive.openBox('form');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openBox();
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
  var nama = '';

  //create item
  Future<void> createItem(Absensi newItem) async {
    await formBox.add(newItem);
    Get.snackbar(
      'Berhasil',
      'Data berhasil disimpan',
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
    );
    Get.offAll(() => HomePage(), arguments: homeController.email);
  }

  //update item
  Future<void> updateItem(int itemKey, Absensi item) async {
    await formBox.put(itemKey, item);
    Get.snackbar(
      'Berhasil',
      'Data berhasil diubah',
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
    );
    Get.offAll(() => HomePage(), arguments: homeController.email);
  }

  void showform(BuildContext ctx, int? itemKey, Absensi item) async {
    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: MediaQuery.of(ctx).viewInsets,
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 500,
                      child: OSMPage(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: TextFormField(
                        controller: controllerKeterangan,
                        decoration: InputDecoration(
                          hintText: 'Keterangan',
                          labelText: 'Keterangan',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (itemKey != null) {
                                  updateItem(
                                      itemKey,
                                      Absensi(
                                          nama: homeController.name,
                                          masjid: selectedValueMasjid.value,
                                          date: selectedDate.value,
                                          sholat: selectedValueSholat.value,
                                          keterangan:
                                              controllerKeterangan.text.trim(),
                                          lokasi: valueLocation.value,
                                          status: "Hadir"));
                                }
                              },
                              child: Text(
                                'Hadir',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                if (itemKey != null) {
                                  updateItem(
                                      itemKey,
                                      Absensi(
                                          nama: homeController.name,
                                          masjid: selectedValueMasjid.value,
                                          date: selectedDate.value,
                                          sholat: selectedValueSholat.value,
                                          keterangan:
                                              controllerKeterangan.text.trim(),
                                          lokasi: "",
                                          status: "izin"));
                                }
                              },
                              child: Text(
                                'Izin',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
