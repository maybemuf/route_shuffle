import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/core/errors/enums.dart';

part 'generated/failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.api({
    required String message,
    required int statusCode,
  }) = ApiFailure;

  const factory Failure.geo({
    required String message,
    required GeoFailureError error,
  }) = GeoFailure;
}
