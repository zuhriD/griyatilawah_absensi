import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryPage extends StatelessWidget {
  var controller = Get.put(HomeController());
  var formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HexColor('20275D'),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100.0),
              ),
            ),
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 24,
                  child: Text(
                    'Riwayat Absensi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Obx(() => controller.jadwalList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: controller.jadwalList.length,
                    itemBuilder: (context, index) {
                      final jadwal = controller.jadwalList[index];
                      return jadwal.status == "sudah_absen" ||
                              jadwal.status == "izin"
                          ? Container(
                              margin: EdgeInsets.fromLTRB(24, 5, 24, 8),
                              child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: HexColor('20275D'),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          child: Container(
                                        width: 23,
                                        decoration: BoxDecoration(
                                          color: HexColor('6DB351'),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            bottomLeft: Radius.circular(16.0),
                                          ),
                                        ),
                                      )),
                                      Positioned(
                                        top: 10,
                                        left: 35,
                                        child: Text(
                                          jadwal.namaImam,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Positioned(
                                        top: 40,
                                        left: 40,
                                        child: Row(
                                          children: [
                                            Text(
                                              jadwal.namaMasjid,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5)),
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                'Lokasi',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              onTap: () {
                                                formController.showLokasiMasjid(
                                                    context,
                                                    jadwal.latitudeMasjid,
                                                    jadwal.longitudeMasjid);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 70,
                                        left: 35,
                                        child: Row(
                                          children: [
                                            Text(
                                              controller.tanggal(jadwal.date),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              " ${jadwal.namaAktivitas}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //make button for check in
                                      Positioned(
                                        top: 40,
                                        right: 20,
                                        child: Row(
                                          children: [
                                            jadwal.status == 'sudah_absen'
                                                ? Text(
                                                    'Sudah Absen',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                  )
                                                : Text(
                                                    'Izin',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                  ),
                                            Icon(
                                              Icons.check,
                                              color: HexColor('6DB351'),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          : Container();
                    },
                  ),
                ))
        ],
      ),
    );
  }
}
