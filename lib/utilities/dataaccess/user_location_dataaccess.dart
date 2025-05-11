import 'package:location_tracking/models/user_location_marker.dart';
import 'package:location_tracking/utilities/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

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

}
