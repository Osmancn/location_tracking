import 'package:json_annotation/json_annotation.dart';

part 'user_location.g.dart';

@JsonSerializable()
class UserLocation {
  int id;
  double x;
  double y;
  DateTime date;

  UserLocation({required this.id, required this.x, required this.y, required this.date});
  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
