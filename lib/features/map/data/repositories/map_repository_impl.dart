import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {

  @override
  ApiResult<Coordinates> getCurrentLocation() {
    throw UnimplementedError();
  }
}
