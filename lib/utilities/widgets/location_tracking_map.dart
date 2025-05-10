import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking/utilities/providers/location_tracking_map_provider.dart';
import 'package:provider/provider.dart';

class LocationTrackingMap extends StatefulWidget {
  const LocationTrackingMap({super.key});

  @override
  State<LocationTrackingMap> createState() => _LocationTrackingMapState();
}

class _LocationTrackingMapState extends State<LocationTrackingMap> {
  late final LocationTrackingMapProvider _locationProvider;

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationTrackingMapProvider();
    _locationProvider.getInitialLocation();
    _locationProvider.startLocationUpdates();
  }

  @override
  void dispose() {
    _locationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationTrackingMapProvider>.value(
      value: _locationProvider,
      child: Consumer<LocationTrackingMapProvider>(
        builder: (context, locationProvider, child) {
          final position = locationProvider.currentPosition;
          if (position == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final currentLatLng = LatLng(position.latitude, position.longitude);

          return GoogleMap(
            initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 16, bearing: locationProvider.bearing),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            rotateGesturesEnabled: true,
            compassEnabled: true,
          );
        },
      ),
    );
  }
}
