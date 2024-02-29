import 'package:app_settings/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/providers/map_repository_provider.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/states/map_state.dart';

part 'generated/map_notifier.g.dart';
typedef GeoSuccessCallback = void Function(Coordinates);
typedef GeoErrorCallback = void Function(GeoFailure, void Function());

@riverpod
class MapNotifier extends _$MapNotifier {
  late MapRepository _mapRepository;

  @override
  MapState build() {
    _mapRepository = ref.read(mapRepositoryProvider);

    return const MapState();
  }

  Future<void> getCurrentLocation({
    required GeoSuccessCallback onSuccess,
    required GeoErrorCallback onError,
  }) async {
    final coords = await _mapRepository.getCurrentLocation();
    coords.when(
      success: onSuccess,
      error: (failure) {
        if (failure is GeoFailure) {
          onError(
            failure, AppSettings.openAppSettings,
          );
        }
      },
    );
  }
}
