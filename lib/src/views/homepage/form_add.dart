import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:griyatilawah_absesnsi/src/models/Absensi.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddAbsensi extends StatelessWidget {
  var controller = Get.put(FormController());
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.controllerNama.text = homeController.name;
    return Scaffold(
        //make me form add absensi
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
                  'Tambah Absensi',
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
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                controller: controller.controllerNama,
                decoration: InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  labelStyle: TextStyle(
                    color: HexColor('20275D'),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor('20275D')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor('20275D')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(
                  color: HexColor('20275D'),
                  fontSize: 16,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedValueMasjid.value,
                      items:
                          controller.dropdownValuesMasjid.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: controller.onDropdownValueMasjidChanged,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  )),

              Padding(padding: EdgeInsets.only(top: 20)),
              //make button date picker
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.black),
                              SizedBox(width: 10.0),
                              Text(
                                controller.selectedDate.value == null
                                    ? 'Pilih Tanggal'
                                    : DateFormat('dd MMMM yyyy')
                                        .format(controller.selectedDate.value),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedValueSholat.value,
                      items:
                          controller.dropdownValuesSholat.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: controller.onDropdownValueSholatChanged,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.createItem(Absensi(
                          nama: controller.controllerNama.text,
                          masjid: controller.selectedValueMasjid.value,
                          date: controller.selectedDate.value,
                          sholat: controller.selectedValueSholat.value,
                          keterangan: "",
                          lokasi: "",
                          status: "belum_hadir"));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: HexColor('20275D'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
