import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:hexcolor/hexcolor.dart';

class AddAbsensi extends StatelessWidget {
  var controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
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
              //make button date picker
              Obx(() => Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                'Pick Date',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    ));
  }
}
