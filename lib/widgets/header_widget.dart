import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/global_controller.dart';
import 'clock_view.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";

  String date = DateFormat("yMMMMd").format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    // city = "Ha Noi";
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      // city = place.toString();
      city = '${place.thoroughfare}';
      // city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.topLeft,
              child: Text(
                city,
                style: const TextStyle(
                    color: Colors.white, fontSize: 25, height: 2),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                date,
                style: const TextStyle(
                    fontSize: 20, color: Colors.white, height: 1.5),
              ),
            ),
          ],
        ),
        const ClockView(size: 100),
        // const SizedBox(
        //   width: 5,
        // )
      ],
    );
  }
}
