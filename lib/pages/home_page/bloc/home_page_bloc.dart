import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracking/utilities/dataaccess/user_location_dataaccess.dart';
import 'package:location_tracking/utilities/services/location_service.dart';
import 'package:location_tracking/utilities/services/preference_service.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(LocationLoadingHomePageState()) {
    on<LoadLocationHomePageEvent>((event, emit) async {
      emit(LocationLoadingHomePageState());
      try {
        await LocationService().checkPermission();
        final locations = await UserLocationDataaccess().getLocations();
        bool locationTrackActive = (await PreferenceService.get(PreferenceKeys.trackActivation, "false")) == "true";
        emit(LocationTrackingHomePageState(userLocations: locations, locationTrackActive: locationTrackActive));
      } catch (e) {
        emit(ErrorHomePageState(message: e.toString()));
      }
    });

    on<ShowMapHomePageEvent>((event, emit) {
      emit(LocationTrackingHomePageState(userLocations: [], locationTrackActive: false));
    });
  }
}
