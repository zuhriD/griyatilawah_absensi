import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/services/notifi_service.dart';
import 'package:griyatilawah_absesnsi/src/views/form_add.dart';
import 'package:griyatilawah_absesnsi/src/views/listview_absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/profile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  var controller = Get.put(HomeController());
  var formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: HexColor('20275D'),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 54,
                        left: 24,
                        child: Text(
                          'Selamat Datang,',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 94,
                        left: 24,
                        child: Text(
                          "Absensi Imam Griya Tilawah",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //make button for logout in top right
                      Positioned(
                        top: 54,
                        right: 24,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.logout();
                          },
                          child: Icon(Icons.logout),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 24,
                        child: Text(
                          controller.name.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(padding: EdgeInsets.only(top: 16)),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Text(
                  'Absensi Hari Ini',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor('20275D')),
                ),
              ),
              Expanded(
                child: formController.items.length < 1 &&
                        controller.name != formController.nama
                    ? Center(child: Text('Tidak ada jadwal hari ini'))
                    : ListView.builder(
                        itemCount: formController.items.length,
                        itemBuilder: (context, index) {
                          final currentItem = formController.items[index];
                          return Container(
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
                                    currentItem['status'] == "belum_hadir"
                                        ? Positioned(
                                            child: Container(
                                            width: 23,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.0),
                                                bottomLeft:
                                                    Radius.circular(16.0),
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
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                              ),
                                            ),
                                          )),
                                    Positioned(
                                      top: 10,
                                      left: 35,
                                      child: Text(
                                        currentItem['nama'].toString(),
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
                                        currentItem['masjid'].toString(),
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
                                            controller.tanggal(
                                                currentItem['tanggal']),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            " " +
                                                currentItem['sholat']
                                                    .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //make button for check in
                                    currentItem['status'] == 'belum_hadir'
                                        ? Positioned(
                                            top: 30,
                                            right: 20,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                NotificationService()
                                                    .showNotification(
                                                        title:
                                                            "Jangan lupa absen",
                                                        body: currentItem[
                                                                'sholat']
                                                            .toString());
                                              },
                                              child: Text('Absen'),
                                              style: ElevatedButton.styleFrom(
                                                primary: HexColor('6DB351'),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                              ),
                                            ),
                                          )
                                        : currentItem['status'] == 'izin'
                                            ? Positioned(
                                                top: 40,
                                                right: 20,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Izin',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                          );
                        },
                      ),
              ),
            ],
          ),
          AddAbsensi(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavyBar(
          selectedIndex: controller.currentIndex.value,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) =>
              controller.changeTab(index), // this is set state
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: HexColor('20275D'),
                inactiveColor: Colors.black,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.add),
                title: Text('Add'),
                activeColor: HexColor('20275D'),
                inactiveColor: Colors.black,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: HexColor('20275D'),
                inactiveColor: Colors.black,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
