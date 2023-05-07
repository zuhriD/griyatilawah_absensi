import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/views/form_add.dart';
import 'package:griyatilawah_absesnsi/src/views/listview_absensi.dart';
import 'package:griyatilawah_absesnsi/src/views/profile.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatelessWidget {
  var controller = Get.put(HomeController());

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
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(24, 5, 24, 8),
                      child: listview_absensi(),
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
