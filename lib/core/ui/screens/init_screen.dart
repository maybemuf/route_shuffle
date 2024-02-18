import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/core/providers/app_init_provider.dart';
import 'package:route_shuffle/core/ui/screens/error_screen.dart';
import 'package:route_shuffle/core/ui/screens/home_screen.dart';
import 'package:route_shuffle/core/ui/screens/splash_screen.dart';

class InitalScreen extends ConsumerWidget {
  const InitalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInit = ref.watch(appInitProvider);
    return appInit.when(
      data: (_) => const HomeScreen(),
      error: (error, stackTrace) => ErrorScreen(
        errorMessage: error.toString(),
        onRetry: () => ref.invalidate(appInitProvider),
      ),
      loading: SplashScreen.new,
    );
  }
}
