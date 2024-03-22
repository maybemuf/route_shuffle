import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/features/map/domain/providers/map_repository_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/place_notifier/places_state.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/starting_location_notifier/starting_location.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/starting_location_notifier/starting_location_notifier.dart';

part 'generated/places_notifier.g.dart';

@riverpod
class PlacesNotifier extends _$PlacesNotifier {
  Timer? _debounce;

  @override
  PlacesState build() {
    ref.onDispose(() => _debounce?.cancel());
    return const PlacesState(places: []);
  }

  Future<void> fetchPlaces(
    String input, {
    void Function(MapApiFailure)? onError,
  }) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      state = state.copyWith(isLoading: true);
      final repository = ref.read(mapRepositoryProvider);
      final result = await repository.autocompletePlaces(input);

      result.when(
        success: (places) {
          state = state.copyWith(places: places, isLoading: false);
        },
        error: (error) {
          if (error is MapApiFailure) {
            onError?.call(error);
          }
          state = state.copyWith(places: [], isLoading: false);
        },
      );
    });
  }

  Future<void> setStartingLocation(
    String placeId, {
    void Function(MapApiFailure)? onError,
  }) async {
    final repository = ref.read(mapRepositoryProvider);
    final result = await repository.getPlaceDetails(placeId);
    if (result.isError) {
      if (result.error is MapApiFailure) {
        onError?.call(result.error as MapApiFailure);
      }
    }
    final place = result.success;
    final startingLocation = StartingLocation(
      address: place.formattedAddress,
      coordinates: place.geometry.location,
    );

    ref
        .read(startingLocationNotifierProvider.notifier)
        .setStartingLocation(startingLocation);
    state = state.copyWith(places: []);
  }

  void clearPlaces() {
    state = state.copyWith(places: []);
  }
}
