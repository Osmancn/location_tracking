import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    await checkPermission();
    return await Geolocator.getCurrentPosition();
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1));
  }

  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw Exception("Konum izni reddedildi");
    }
    return true;
  }
}
