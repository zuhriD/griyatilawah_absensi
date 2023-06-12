import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/osm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

class FormController extends GetxController {
  final controllerNama = TextEditingController();
  final controllerMasjid = TextEditingController();
  final controllerDate = TextEditingController();
  final controllerSholat = TextEditingController();
  final controllerKeterangan = TextEditingController();

  var valueLocation = ''.obs;

  final homeController = Get.find<HomeController>();

  var namaAktivitas = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showLokasiMasjid(BuildContext ctx, String lat, String long) {
    // convert String to double
    double latDouble = double.parse(lat);
    double longDouble = double.parse(long);
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
                      child: OSMPage(
                        lat: latDouble,
                        lng: longDouble,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void launchMap(double lat, double lng) async {
    final title = "Lokasi Tujuan";
    final description = "Deskripsi Tujuan";
    final coords = Coords(lat, lng);

    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isNotEmpty) {
        final mapType = availableMaps.first;

        await mapType.showMarker(
          coords: coords,
          title: title,
          description: description,
        );
      } else {
        print('No maps available.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Rx<File?> image =
      Rx<File?>(null); // Menggunakan Rx untuk mengamati perubahan file gambar

  Future<void> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      image.value = File(imagePicked.path);
    }
  }

  // make function to post data to api
  void showAbsensi(BuildContext ctx, int id) async {
    TextEditingController keteranganController = TextEditingController();

    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: MediaQuery.of(ctx).viewInsets,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // make controller to show image picker
                  Obx(() => image.value != null
                      ? Image.file(
                          image.value!,
                          width: 200,
                          height: 200,
                        )
                      : Container()),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: keteranganController,
                      decoration: InputDecoration(
                        labelText: 'Keterangan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await getImage();
                        },
                        child: Text('Upload Foto'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Tombol Hadir diklik
                        },
                        child: Text('Hadir'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Tombol Izin diklik
                        },
                        child: Text('Izin'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
