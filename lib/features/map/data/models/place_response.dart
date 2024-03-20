import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';

part 'generated/place_response.freezed.dart';
part 'generated/place_response.g.dart';

@freezed
class PlaceResponse with _$PlaceResponse {
  const factory PlaceResponse({
    required Place result,
    required MapApiResponseStatus status,
  }) = _PlaceResponse;

  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);
}
