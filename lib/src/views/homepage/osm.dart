import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/services/location.services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OSMPage extends StatelessWidget {
  final LocationService locationService = LocationService();
  var formController = Get.put(FormController());
  final double lat;
  final double lng;

  // make parameter lat lang
  OSMPage({Key? key, required this.lat, required this.lng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
      center: LatLong(lat, lng),
      buttonColor: Colors.blue,
      buttonText: 'Lihat Lokasi di Google Maps',
      onPicked: (pickedData) {
        formController.launchMap(lat, lng);
      },
      onGetCurrentLocationPressed: locationService.getPosition,
    );
  }
}
