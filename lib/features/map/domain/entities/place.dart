import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/geolocation_geometry.dart';

part 'generated/place.freezed.dart';
part 'generated/place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String formattedAddress,
    required GeolocationGeometry geometry,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
