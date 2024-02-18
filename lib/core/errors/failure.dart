import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.api({
    required String message,
    required int statusCode,
  }) = ApiFailure;

  const factory Failure.local({
    required String message,
  }) = LocalFailure;
}
