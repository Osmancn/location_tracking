import 'package:json_annotation/json_annotation.dart';

part 'user_location_marker.g.dart';

@JsonSerializable()
class UserLocationMarker {
  int id;
  double x;
  double y;
  DateTime date;

  UserLocationMarker({required this.id, required this.x, required this.y, required this.date});
  factory UserLocationMarker.fromJson(Map<String, dynamic> json) =>
      _$UserLocationMarkerFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationMarkerToJson(this);
}
