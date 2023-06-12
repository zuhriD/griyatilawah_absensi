import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/homepage/osm.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

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

  // void showform(BuildContext ctx, int? itemKey, Absensi item) async {
  //   showModalBottomSheet(
  //       context: ctx,
  //       elevation: 5,
  //       isScrollControlled: true,
  //       builder: (_) => Container(
  //             padding: MediaQuery.of(ctx).viewInsets,
  //             child: Form(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(10),
  //                     height: 500,
  //                     child: OSMPage(),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
  //                     child: TextFormField(
  //                       controller: controllerKeterangan,
  //                       decoration: InputDecoration(
  //                         hintText: 'Keterangan',
  //                         labelText: 'Keterangan',
  //                         labelStyle: TextStyle(
  //                           color: Colors.black,
  //                         ),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.all(10),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         ElevatedButton(
  //                             onPressed: () {
  //                               if (itemKey != null) {}
  //                             },
  //                             child: Text(
  //                               'Hadir',
  //                               style: GoogleFonts.poppins(
  //                                   fontWeight: FontWeight.w600, fontSize: 16),
  //                             ),
  //                             style: ElevatedButton.styleFrom(
  //                               primary: Colors.green,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10)),
  //                             )),
  //                         ElevatedButton(
  //                             onPressed: () {
  //                               if (itemKey != null) {}
  //                             },
  //                             child: Text(
  //                               'Izin',
  //                               style: GoogleFonts.poppins(
  //                                   fontWeight: FontWeight.w600, fontSize: 16),
  //                             ),
  //                             style: ElevatedButton.styleFrom(
  //                               primary: Colors.red,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10)),
  //                             )),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ));
  // }

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
}
