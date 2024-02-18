import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final GeolocationService _geolocationService;

  MapRepositoryImpl({required GeolocationService geolocationService})
      : _geolocationService = geolocationService;

  @override
  FutureResult<Coordinates> getCurrentLocation() async {
    try {
      final coordinates = await _geolocationService.getCurrentLocation();
      return success(coordinates);
    } on GeoFailure catch (e) {
      return error(GeoFailure(message: e.message, error: e.error));
    }
  }
}
