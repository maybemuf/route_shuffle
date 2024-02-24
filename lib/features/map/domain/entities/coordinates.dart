import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/coordinates.freezed.dart';

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({
    required double latitude,
    required double longitude,
  }) = _Coordinates;
}
