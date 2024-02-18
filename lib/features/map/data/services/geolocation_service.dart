import 'package:geolocator/geolocator.dart';
import 'package:route_shuffle/core/errors/enums.dart';
import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

abstract interface class GeolocationService {
  Future<Coordinates> getCurrentLocation();
}

class GeolocationServiceImpl implements GeolocationService {

  @override
  Future<Coordinates> getCurrentLocation() async {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw GeolocationException(
        message: 'Location services are disabled',
        failure: GeoFailureError.serviceDisabled,
      );
    }

    // Check if location permissions are granted
    await _checkPermission();

    final currentPosition = await Geolocator.getCurrentPosition();

    return Coordinates(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );
  }

  Future<void> _checkPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GeolocationException(
          message: 'Location permissions are denied',
          failure: GeoFailureError.permissionDenied,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw GeolocationException(
        message: 'Location permissions are permanently denied',
        failure: GeoFailureError.permissionDeniedForever,
      );
    }
  }
}

