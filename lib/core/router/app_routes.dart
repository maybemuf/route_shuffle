/// This file contains the routes of the app
enum AppRoutes {
  splash,
  locationPermission,
  map,
}

/// Extension to get the path and the name of the route
extension AppRoutesExtension on AppRoutes {
  /// Returns the path of the route
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return '/';
      case AppRoutes.locationPermission:
        return '/location-permission';
      case AppRoutes.map:
        return '/map';
    }
  }

  /// Returns the name of the route
  String get named {
    switch (this) {
      case AppRoutes.splash:
        return 'InitialScreen';
      case AppRoutes.locationPermission:
        return 'LocationPermission';
      case AppRoutes.map:
        return 'MapScreen';
    }
  }
}
