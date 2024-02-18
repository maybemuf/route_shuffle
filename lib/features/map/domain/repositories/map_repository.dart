import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';

abstract interface class MapRepository {
  FutureResult<Coordinates> getCurrentLocation();
}
