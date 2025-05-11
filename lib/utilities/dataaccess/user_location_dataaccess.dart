import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/main.dart';
import 'package:location_tracking/models/user_location_marker.dart';
import 'package:location_tracking/utilities/services/database_service.dart';

class UserLocationDataaccess {
  static UserLocationDataaccess? _userLocationDataaccess;

  factory UserLocationDataaccess() {
    _userLocationDataaccess ??= UserLocationDataaccess._initiliaze();
    return _userLocationDataaccess!;
  }

  UserLocationDataaccess._initiliaze();

  Future<List<UserLocationMarker>> getLocations() async {
    var database = await DatabaseService().getDatabase();
    var userLocationTable = await database.query("UserLocation");
    var userLocationTableQuery = userLocationTable.where((element) => true);
    return List<UserLocationMarker>.from(userLocationTableQuery.map((x) => UserLocationMarker.fromJson(x)));
  }

  Future setNewLocation(UserLocationMarker newLocation) async {
    var database = await DatabaseService().getDatabase();
    await database.insert("UserLocation", newLocation.toJson());
  }

  Future clearLocations() async {
    var database = await DatabaseService().getDatabase();
    await database.delete("UserLocation");
  }

  Future setNewLocationWithDbCheck(UserLocationMarker newLocation) async {
    var database = await DatabaseService().getDatabase();
    var userLocationTable = await database.query("UserLocation");
    UserLocationMarker? lastLocation;
    try {
      lastLocation = UserLocationMarker.fromJson(userLocationTable.last);
      // ignore: empty_catches
    } catch (e) {}
    if (lastLocation == null) {
      await setNewLocation(newLocation);
    } else {
      final distance = Geolocator.distanceBetween(lastLocation.x, lastLocation.y, newLocation.x, newLocation.y);
      if (distance >= trackDistance) {
        newLocation.id = lastLocation.id + 1;
        await setNewLocation(newLocation);
      }
    }
  }
}
