import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/location_permission_status.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/geolocation_status_provider.dart';

class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(geolocationStatusProvider).requireValue;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                const Icon(
                  Icons.location_on,
                  size: 100,
                ),
                const SizedBox(height: 24),
                Text(
                  status == LocationPermissionStatus.denied
                      ? 'Location Permission Denied'
                      : 'Location Permission Denied Forever',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  status == LocationPermissionStatus.denied
                      ? 'You have denied location permission. Please enable it in the settings.'
                      : 'You have denied location permission forever. Please enable it in the settings.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (status == LocationPermissionStatus.denied) {
                      ref
                          .read(geolocationStatusProvider.notifier)
                          .requestPermission();
                    } else {
                      ref
                          .read(geolocationStatusProvider.notifier)
                          .openSettings();
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      status == LocationPermissionStatus.denied
                          ? 'Request Permission'
                          : 'Open Settings',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
