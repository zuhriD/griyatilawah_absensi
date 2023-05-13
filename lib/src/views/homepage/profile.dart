import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/controllers/home_controller.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatelessWidget {
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //make me profile page
      body: Column(children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: HexColor('20275D'),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
          ),
          margin: EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 150,
                child: Text(
                  'Profile',
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
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/user.png'),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              'Nama     : ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor('20275D'),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              controller.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor('20275D'),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              'Email      : ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor('20275D'),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              controller.email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor('20275D'),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
