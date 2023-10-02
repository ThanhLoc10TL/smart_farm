import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitue = 0.0.obs;
  final RxDouble _longitue = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitue;
  RxDouble getLongitude() => _longitue;

  @override
  void onInit() {
    if (_isLoading.isTrue) getLocation();
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) return Future.error("Location not enabled");

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission not enabled");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permisstion is denied");
      }
    }

    //getting the current position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //update our location
      _lattitue.value = value.latitude;
      _longitue.value = value.longitude;
      _isLoading.value = false;
    });
  }
}
