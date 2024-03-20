import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';

part 'generated/autocomplete_response.freezed.dart';
part 'generated/autocomplete_response.g.dart';

@freezed
class AutocompleteResponse with _$AutocompleteResponse {
  const factory AutocompleteResponse({
    required List<PlacePrediction> predictions,
    required MapApiResponseStatus status,
  }) = _AutocompleteResponse;

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResponseFromJson(json);
}
