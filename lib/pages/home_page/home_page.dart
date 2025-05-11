import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/widgets/location_tracking_map.dart';
import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Location Tracking")),
      body: BlocProvider(
        create: (context) => HomePageBloc()..add(LoadLocationHomePageEvent()), // Trigger LoadLocationEvent when the page loads
        child: BlocConsumer<HomePageBloc, HomePageState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LocationLoadingHomePageState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LocationTrackingHomePageState) {
              return LocationTrackingMap(userLocations: state.userLocations, locationTrackActive: state.locationTrackActive);
            }
            if (state is ErrorHomePageState) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("No locations available"));
          },
        ),
      ),
    );
  }
}
