import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/geolocation_geometry.dart';

part 'generated/geocoding_result.freezed.dart';
part 'generated/geocoding_result.g.dart';

@freezed
class GeocodingResult with _$GeocodingResult {
  const factory GeocodingResult({
    required String formattedAddress,
    required GeolocationGeometry geometry,
    required String placeId,
  }) = _GeocodingResult;

  factory GeocodingResult.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResultFromJson(json);
}
