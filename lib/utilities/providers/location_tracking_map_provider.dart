import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class LocationTrackingMapProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();

  Position? _currentPosition;
  double _bearing = 0.0;

  Position? get currentPosition => _currentPosition;
  double get bearing => _bearing;

  void startLocationUpdates() {
    _locationService.getPositionStream().listen((position) {
      _currentPosition = position;
      _bearing = position.heading;
      notifyListeners();
    });
  }

  Future<void> getInitialLocation() async {
    _currentPosition = await _locationService.getCurrentPosition();
    notifyListeners();
  }
}
