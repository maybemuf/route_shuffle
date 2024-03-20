import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/place.freezed.dart';
part 'generated/place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String placeId,
    required String description,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
