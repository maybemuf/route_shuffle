import 'package:json_annotation/json_annotation.dart';

enum MapApiResponseStatus {
  @JsonValue('OK')
  ok,
  @JsonValue('ZERO_RESULTS')
  zeroResults,
  @JsonValue('OVER_QUERY_LIMIT')
  overQueryLimit,
  @JsonValue('REQUEST_DENIED')
  requestDenied,
  @JsonValue('INVALID_REQUEST')
  invalidRequest,
  @JsonValue('UNKNOWN_ERROR')
  unknownError,
}

extension MapApiResponseStatusX on MapApiResponseStatus {
  bool get isOk =>
      this == MapApiResponseStatus.ok ||
      this == MapApiResponseStatus.zeroResults;

  bool get isError => !isOk;
}
