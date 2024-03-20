import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';

part 'generated/geocoding_response.freezed.dart';
part 'generated/geocoding_response.g.dart';

@freezed
class GeocodingResponse with _$GeocodingResponse {
  const factory GeocodingResponse({
    required List<GeocodingResult> results,
    required MapApiResponseStatus status,
  }) = _GeocodingResponse;

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResponseFromJson(json);
}
