import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:griyatilawah_absesnsi/src/controllers/form_controller.dart';
import 'package:griyatilawah_absesnsi/src/services/location.services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OSMPage extends StatelessWidget {
  final LocationService locationService = LocationService();
  var formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
      center: LatLong(-6.2088, 106.8456),
      buttonColor: Colors.blue,
      buttonText: 'Set Current Location',
      onPicked: (pickedData) {
        formController.valueLocation(pickedData.address);
      },
      onGetCurrentLocationPressed: locationService.getPosition,
    );
  }
}
