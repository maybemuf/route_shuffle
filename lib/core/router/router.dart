import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:route_shuffle/core/router/app_routes.dart';
import 'package:route_shuffle/core/ui/screens/init_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.initialScreen.path,
  routes: [
    GoRoute(
      path: AppRoutes.initialScreen.path,
      pageBuilder: (context, state) =>
          const MaterialPage(child: InitalScreen()),
    ),
  ],
);
