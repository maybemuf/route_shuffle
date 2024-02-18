import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:route_shuffle/core/errors/failure.dart';

part 'generated/api_result.freezed.dart';

@freezed
sealed class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.error(Failure failure) = Error;
}
