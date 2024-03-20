import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/coordinates.freezed.dart';
part 'generated/coordinates.g.dart';

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({
    required double lat,
    required double lng,
    @Default(0.0) double heading,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}
