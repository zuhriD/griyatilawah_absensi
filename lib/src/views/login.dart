import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griyatilawah_absesnsi/src/controllers/auth_controller.dart';
import 'package:griyatilawah_absesnsi/src/views/register.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 131,
              width: 336,
            ),
            const Padding(padding: EdgeInsets.all(50)),
            Text(
              'Login',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HexColor('20275D')),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              margin: EdgeInsets.fromLTRB(38, 0, 29, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Obx(
                    () => TextFormField(
                      controller: controller.controllerPassword,
                      obscureText:
                          controller.passwordVisibility.value ? false : true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.passwordVisibility.value =
                                !controller.passwordVisibility.value;
                          },
                          child: Icon(
                            controller.passwordVisibility.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 347,
              height: 146,
              margin: EdgeInsets.fromLTRB(38, 0, 29, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 347,
                    height: 42,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("20275D"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        child: Text('Login',
                            style: GoogleFonts.getFont('Poppins',
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        onPressed: () {
                          controller.login();
                        }),
                  ),
                  Container(
                    height: 21,
                    width: 347,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont have an account?',
                            style: GoogleFonts.getFont('Poppins',
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey))),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => RegisterPage());
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text('Sign Up?',
                                style: GoogleFonts.getFont('Poppins',
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("92CB69")))),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
