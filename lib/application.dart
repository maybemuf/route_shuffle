import 'package:flutter/material.dart';
import 'package:route_shuffle/core/router/router.dart';
import 'package:route_shuffle/core/ui/theme/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
