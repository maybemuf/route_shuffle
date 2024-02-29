import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:route_shuffle/core/router/app_routes.dart';
import 'package:route_shuffle/core/ui/screens/splash_screen.dart';
import 'package:route_shuffle/core/ui/screens/wrapper_screen.dart';
import 'package:route_shuffle/features/map/presentation/screens/location_permission_screen.dart';
import 'package:route_shuffle/features/map/presentation/screens/map_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return WrapperScreen(
          key: state.pageKey,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash.path,
          name: AppRoutes.splash.named,
          pageBuilder: (context, state) => const MaterialPage(
            child: SplashScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.locationPermission.path,
          name: AppRoutes.locationPermission.named,
          pageBuilder: (context, state) => const MaterialPage(
            child: LocationPermissionScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.map.path,
          name: AppRoutes.map.named,
          pageBuilder: (context, state) => const MaterialPage(
            child: MapScreen(),
          ),
        ),
      ],
    ),
  ],
);
