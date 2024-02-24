import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

part 'generated/geolocation_geometry.freezed.dart';
part 'generated/geolocation_geometry.g.dart';

@freezed
class GeolocationGeometry with _$GeolocationGeometry {
  const factory GeolocationGeometry({
    required Coordinates location,
  }) = _GeolocationGeometry;

  factory GeolocationGeometry.fromJson(Map<String, dynamic> json) =>
      _$GeolocationGeometryFromJson(json);
}