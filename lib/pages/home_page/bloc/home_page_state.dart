import 'package:location_tracking/models/user_location_marker.dart';

abstract class HomePageState {}

class LocationLoadingHomePageState extends HomePageState {}

class LocationTrackingHomePageState extends HomePageState {
  List<UserLocationMarker> userLocations;
  bool locationTrackActive;

  LocationTrackingHomePageState({required this.userLocations, required this.locationTrackActive});
}

class ErrorHomePageState extends HomePageState {
  final String message;

  ErrorHomePageState({required this.message});
}
