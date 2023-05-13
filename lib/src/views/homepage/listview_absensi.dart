import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:griyatilawah_absesnsi/src/services/notifi_service.dart';
import 'package:hexcolor/hexcolor.dart';

class listview_absensi extends StatelessWidget {
  // final Map<String, dynamic> data = Get.arguments;
  var controller = Get.put(HomeController());
  var formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return formController.formBox.length < 1
        ? Center(child: Text('Tidak ada jadwal hari ini'))
        : ListView.builder(
            itemCount: formController.formBox.length,
            itemBuilder: (context, index) {
              // final currentItem = formController.items[index];
              Absensi absensi = formController.formBox.getAt(index);
              return absensi == null || absensi.nama != controller.name
                  ? Container()
                  : absensi.status == "belum_hadir"
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
                                  absensi.status == "belum_hadir"
                                      ? Positioned(
                                          child: Container(
                                          width: 23,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              bottomLeft: Radius.circular(16.0),
                                            ),
                                          ),
                                        ))
                                      : Positioned(
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
                                      absensi.nama,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 35,
                                    child: Text(
                                      absensi.masjid,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    top: 70,
                                    left: 35,
                                    child: Row(
                                      children: [
                                        Text(
                                          controller.tanggal(absensi.date),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          " ${absensi.sholat}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //make button for check in
                                  absensi.status == 'belum_hadir'
                                      ? Positioned(
                                          top: 30,
                                          right: 20,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              formController.showform(
                                                  context,
                                                  index,
                                                  Absensi(
                                                      nama: absensi.nama,
                                                      masjid: absensi.masjid,
                                                      date: absensi.date,
                                                      sholat: absensi.sholat,
                                                      keterangan: "",
                                                      lokasi: "",
                                                      status: "Hadir"));
                                            },
                                            child: Text('Absen'),
                                            style: ElevatedButton.styleFrom(
                                              primary: HexColor('6DB351'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      : absensi.status == 'izin'
                                          ? Positioned(
                                              top: 40,
                                              right: 20,
                                              child: Row(
                                                children: [
                                                  Text(
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
                                          : Positioned(
                                              top: 40,
                                              right: 20,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Sudah Absen',
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
                                            ),
                                ],
                              )),
                        )
                      : Container();
            },
          );
  }
}
