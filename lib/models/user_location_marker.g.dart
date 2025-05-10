// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationMarker _$UserLocationMarkerFromJson(Map<String, dynamic> json) =>
    UserLocationMarker(
      id: (json['id'] as num).toInt(),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UserLocationMarkerToJson(UserLocationMarker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'x': instance.x,
      'y': instance.y,
      'date': instance.date.toIso8601String(),
    };
