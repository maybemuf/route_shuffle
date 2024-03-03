import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/location_permission_status.dart';

abstract interface class GeolocationService {
  Future<Coordinates> getCurrentLocation();

  Future<Stream<Coordinates>> watchCurrentLocation();

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
      heading: currentPosition.heading,
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

  @override
  Future<Stream<Coordinates>> watchCurrentLocation() async {
    late final LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(distanceFilter: 10);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      locationSettings = AppleSettings(distanceFilter: 10);
    }

    final locationStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    );

    return locationStream.map((position) {
      return Coordinates(
        lat: position.latitude,
        lng: position.longitude,
        heading: position.heading,
      );
    });
  }
}
