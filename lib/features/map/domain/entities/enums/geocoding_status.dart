import 'package:json_annotation/json_annotation.dart';

enum GeocodingStatus {
  @JsonValue('OK') ok,
  @JsonValue('ZERO_RESULTS') zeroResults,
  @JsonValue('OVER_QUERY_LIMIT') overQueryLimit,
  @JsonValue('REQUEST_DENIED') requestDenied,
  @JsonValue('INVALID_REQUEST') invalidRequest,
  @JsonValue('UNKNOWN_ERROR') unknownError,
}
