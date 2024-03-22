import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';

part 'generated/places_state.freezed.dart';

@freezed
class PlacesState with _$PlacesState {
  const factory PlacesState({
    required List<PlacePrediction> places,
    @Default(false) bool isLoading,
  }) = _PlacesState;
}
