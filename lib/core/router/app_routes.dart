/// This file contains the routes of the app
enum AppRoutes {
  initialScreen,
}

/// Extension to get the path and the name of the route
extension AppRoutesExtension on AppRoutes {
  /// Returns the path of the route
  String get path {
    switch (this) {
      case AppRoutes.initialScreen:
        return '/';
    }
  }

  /// Returns the name of the route
  String get named {
    switch (this) {
      case AppRoutes.initialScreen:
        return 'InitialScreen';
    }
  }
}
