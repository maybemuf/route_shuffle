import 'package:geolocator/geolocator.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/location_permission_status.dart';

abstract interface class GeolocationService {
  Future<Coordinates> getCurrentLocation();

  Future<LocationPermissionStatus> checkPermission();

  Future<void> requestPermission();
}

class GeolocationServiceImpl implements GeolocationService {
  @override
  Future<Coordinates> getCurrentLocation() async {
    final currentPosition = await Geolocator.getCurrentPosition();

    return Coordinates(
      lat: currentPosition.latitude,
      lng: currentPosition.longitude,
    );
  }

  @override
  Future<LocationPermissionStatus> checkPermission() async {
    // Check if location service is enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      return LocationPermissionStatus.serviceDisabled;
    }

    final permission = await Geolocator.checkPermission();

    return switch (permission) {
      LocationPermission.unableToDetermine ||
      LocationPermission.denied =>
        LocationPermissionStatus.denied,
      LocationPermission.deniedForever =>
        LocationPermissionStatus.deniedForever,
      LocationPermission.whileInUse ||
      LocationPermission.always =>
        LocationPermissionStatus.granted,
    };
  }

  @override
  Future<void> requestPermission() {
    return Geolocator.requestPermission();
  }
}
