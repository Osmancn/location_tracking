import 'package:location_tracking/models/user_location.dart';

abstract class HomePageState {}

class LocationLoadingHomePageState extends HomePageState {}

class LocationTrackingHomePageState extends HomePageState {
  List<UserLocation> userLocations;
  bool locationTrackActive;

  LocationTrackingHomePageState({required this.userLocations, required this.locationTrackActive});
}

class ErrorHomePageState extends HomePageState {
  final String message;

  ErrorHomePageState({required this.message});
}
