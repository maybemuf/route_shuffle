import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/geocoding_status.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';

part 'generated/geocoding_response.freezed.dart';
part 'generated/geocoding_response.g.dart';

@freezed
class GeocodingResponse with _$GeocodingResponse {
  const factory GeocodingResponse({
    required GeocodingResult results,
    required GeocodingStatus status,
  }) = _GeocodingResponse;

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResponseFromJson(json);
}
