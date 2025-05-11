import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking/models/user_location_marker.dart';
import 'package:location_tracking/utilities/providers/location_tracking_map_provider.dart';
import 'package:provider/provider.dart';

class LocationTrackingMap extends StatefulWidget {
  final List<UserLocationMarker> userLocations;
  final bool locationTrackActive;

  const LocationTrackingMap({required this.userLocations, required this.locationTrackActive, super.key});

  @override
  State<LocationTrackingMap> createState() => _LocationTrackingMapState();
}

class _LocationTrackingMapState extends State<LocationTrackingMap> {
  late final LocationTrackingMapProvider _locationProvider;

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationTrackingMapProvider(locationMarkers: widget.userLocations, locationTrackActive: widget.locationTrackActive);
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
          final currentLatLng = LatLng(position?.latitude ?? 40.9707867, position?.longitude ?? 29.0910574);

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 16),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    rotateGesturesEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      locationProvider.setMapController(controller);
                    },
                    markers: locationProvider.createMarkers(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: locationProvider.clearPositions, child: const Text("Konumları Temizle")),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: locationProvider.changeLocationTrackActivation,
                      style: ElevatedButton.styleFrom(backgroundColor: locationProvider.locationTrackActive ? Colors.red : Colors.blue),
                      child: Text(locationProvider.locationTrackActive ? "Takibi Durdur" : "Takibi Başlat"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
