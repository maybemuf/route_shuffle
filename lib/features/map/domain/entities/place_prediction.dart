import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/place_prediction.freezed.dart';
part 'generated/place_prediction.g.dart';

@freezed
class PlacePrediction with _$PlacePrediction {
  const factory PlacePrediction({
    required String placePredictionId,
    required String description,
  }) = _PlacePrediction;

  factory PlacePrediction.fromJson(Map<String, dynamic> json) =>
      _$PlacePredictionFromJson(json);
}
