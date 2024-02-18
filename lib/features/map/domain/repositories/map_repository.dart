import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

abstract interface class MapRepository {
  ApiResult<Coordinates> getCurrentLocation();
}