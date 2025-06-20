import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking/models/user_location.dart';
import 'package:location_tracking/utilities/dataaccess/user_location_dataaccess.dart';
import '../../main.dart';
import '../services/location_service.dart';
import '../services/preference_service.dart';

class LocationTrackingMapProvider with ChangeNotifier {

  final LocationService _locationService = LocationService();
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _currentPositionStream;
  Position? _currentPosition;
  List<UserLocation> _userLocations;
  bool _locationTrackActive;

  Position? get currentPosition => _currentPosition;
  bool get locationTrackActive => _locationTrackActive;
  List<UserLocation> get userLocations => _userLocations;

  LocationTrackingMapProvider({required List<UserLocation> locationMarkers, bool locationTrackActive = true})
    : _userLocations = locationMarkers,
      _locationTrackActive = locationTrackActive {
    getInitialLocation();
    changeLocationTrackActivation(locationTrackActive: locationTrackActive);
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  void startLocationUpdates() {
    if (_currentPositionStream != null) {
      _currentPositionStream!.cancel();
    }
    _currentPositionStream = _locationService.getPositionStream().listen((position) {
      _currentPosition = position;
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16)));
      UserLocationDataaccess().getLocations().then((locations) {
        _userLocations = locations;
        notifyListeners();
      });
    });
  }

  Future<void> getInitialLocation() async {
    _currentPosition = await _locationService.getCurrentPosition();
    notifyListeners();
  }

  void changeLocationTrackActivation({bool? locationTrackActive}) {
    _locationTrackActive = locationTrackActive ?? !_locationTrackActive;
    PreferenceService.set(PreferenceKeys.trackActivation, _locationTrackActive.toString());
    startLocationUpdates();
    startStopLocationTracking(_locationTrackActive);
    notifyListeners();
  }

  Set<Marker> createMarkers() {
    return _userLocations.map((marker) {
      return Marker(markerId: MarkerId(marker.id.toString()), position: LatLng(marker.x, marker.y), infoWindow: InfoWindow(title: '${marker.id}', snippet: '${marker.date}'));
    }).toSet();
  }

  Future clearPositions() async {
    userLocations.clear();
    UserLocationDataaccess().clearLocations();
    notifyListeners();
  }

  @override
  void dispose() {
    _currentPositionStream?.cancel();
    _mapController?.dispose();
    super.dispose();
  }
}
