import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:route_shuffle/core/providers/app_init_provider.dart';
import 'package:route_shuffle/core/router/app_routes.dart';
import 'package:route_shuffle/core/ui/screens/error_screen.dart';
import 'package:route_shuffle/core/ui/screens/splash_screen.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/location_permission_status.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/geolocation_status_provider.dart';

class WrapperScreen extends ConsumerStatefulWidget {
  final Widget child;

  const WrapperScreen({
    required this.child,
    super.key,
  });

  @override
  ConsumerState<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends ConsumerState<WrapperScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(geolocationStatusProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appInit = ref.watch(appInitProvider);
    _setupListeners();
    return appInit.when(
      data: (_) => widget.child,
      error: (error, stackTrace) => ErrorScreen(
        errorMessage: error.toString(),
        onRetry: () => ref.invalidate(appInitProvider),
      ),
      loading: SplashScreen.new,
    );
  }

  void _setupListeners() {
    ref.listen(geolocationStatusProvider, (previous, next) {
      if (previous != next) {
        next.whenData(
          (status) => context.goNamed(
            status == LocationPermissionStatus.granted
                ? AppRoutes.map.named
                : AppRoutes.locationPermission.named,
          ),
        );
      }
    });
  }
}
