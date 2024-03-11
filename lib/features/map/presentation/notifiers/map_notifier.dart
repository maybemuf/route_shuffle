import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/providers/map_repository_provider.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';
import 'package:route_shuffle/features/map/presentation/notifiers/states/map_state.dart';

part 'generated/map_notifier.g.dart';

typedef GeoSuccessCallback = void Function(Coordinates);
typedef GeoErrorCallback = void Function(GeoFailure);

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
    state = state.copyWith(isLoading: true);
    final coords = await _mapRepository.getCurrentLocation();
    coords.when(
      success: (coords) {
        state = state.copyWith(
          initialLocation: coords,
          userMarker: Marker(
            markerId: const MarkerId('userMarker'),
            position: LatLng(coords.lat, coords.lng),
            rotation: 40,
          ),
        );
        onSuccess(coords);
      },
      error: (failure) {
        if (failure is GeoFailure) {
          onError(failure);
        }
      },
    );
    state = state.copyWith(isLoading: false);
  }
}
