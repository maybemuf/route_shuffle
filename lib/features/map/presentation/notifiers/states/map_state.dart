import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

part 'generated/map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    Coordinates? initialLocation,
    Marker? userMarker,
    @Default(false) bool isLoading,
  }) = _MapState;
}
