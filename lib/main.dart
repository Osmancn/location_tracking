import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter/material.dart';
import 'package:location_tracking/models/user_location_marker.dart';
import 'package:location_tracking/pages/home_page/home_page.dart';
import 'package:location_tracking/utilities/dataaccess/user_location_dataaccess.dart';

@pragma('vm:entry-point')
void backgroundCallback() {
  BackgroundLocationTrackerManager.handleBackgroundUpdated((data) async {
    UserLocationDataaccess().setNewLocationWithDbCheck(UserLocationMarker(id: 0, x: data.lat, y: data.lon, date: DateTime.now()));
  });
}

Future startStopLocationTracking(bool active) async {
  if (active) {
    await BackgroundLocationTrackerManager.startTracking();
  } else {
    await BackgroundLocationTrackerManager.stopTracking();
  }
}
final double trackDistance=100;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundLocationTrackerManager.initialize(
    backgroundCallback,
    config: BackgroundLocationTrackerConfig(
      loggingEnabled: true,
      androidConfig: AndroidConfig(notificationIcon: 'explore', trackingInterval: const Duration(seconds: 4), distanceFilterMeters: trackDistance),
      iOSConfig: IOSConfig(activityType: ActivityType.FITNESS, distanceFilterMeters: trackDistance.floor(), restartAfterKill: false),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Location Tracking', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: const HomePage());
  }
}
