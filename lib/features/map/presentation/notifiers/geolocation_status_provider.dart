import 'package:app_settings/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/location_permission_status.dart';
import 'package:route_shuffle/features/map/domain/providers/geolocation_service_provider.dart';

part 'generated/geolocation_status_provider.g.dart';

@riverpod
class GeolocationStatus extends _$GeolocationStatus {

  @override
  Future<LocationPermissionStatus> build() async {
    return ref.read(geolocationServiceProvider).checkPermission();
  }

  Future<void> requestPermission() async {
    final geolocationService = ref.read(geolocationServiceProvider);

    await geolocationService.requestPermission();
    await update((state) async => geolocationService.checkPermission());
  }

  Future<void> openSettings() async => AppSettings.openAppSettings();
}
