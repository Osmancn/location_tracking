import 'package:flutter/material.dart';

import '../utilities/widgets/location_tracking_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Location Tracking")),
      body: LocationTrackingMap(),
    );
  }
}
