import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/core/errors/enums.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';

part 'generated/failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.mapApi({
    required String message,
    required int statusCode,
    required MapApiResponseStatus status,
  }) = MapApiFailure;

  const factory Failure.geo({
    required String message,
    required GeoFailureError error,
  }) = GeoFailure;
}
