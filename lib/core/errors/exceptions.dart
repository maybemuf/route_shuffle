import 'package:route_shuffle/core/errors/enums.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';

class GeolocationException implements Exception {
  final String message;
  final GeoFailureError failure;

  GeolocationException({
    required this.message,
    required this.failure,
  });
}

class MapApiException implements Exception {
  final String message;
  final int statusCode;
  final MapApiResponseStatus status;

  MapApiException({
    required this.message,
    required this.statusCode,
    required this.status,
  });
}
