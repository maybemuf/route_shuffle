import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

part 'generated/starting_location.freezed.dart';

@freezed
class StartingLocation with _$StartingLocation {
  const factory StartingLocation({
    required String address,
    required Coordinates coordinates,
  }) = _StartingLocation;
}
