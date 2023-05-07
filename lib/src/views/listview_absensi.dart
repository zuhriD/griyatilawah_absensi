import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class listview_absensi extends StatelessWidget {
  const listview_absensi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Masjid Al-Ikhlas',
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
                'Sholah Subuh',
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
                    'Hari ini ',
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    '07:00',
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
              top: 30,
              right: 20,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Absen'),
                style: ElevatedButton.styleFrom(
                  primary: HexColor('6DB351'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
