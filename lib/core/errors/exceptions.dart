import 'package:route_shuffle/core/errors/enums.dart';

class GeolocationException implements Exception {
  final String message;
  final GeoFailureError failure;

  GeolocationException({
    required this.message,
    required this.failure,
  });
}