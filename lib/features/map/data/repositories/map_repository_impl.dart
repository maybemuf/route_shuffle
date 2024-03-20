import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';
import 'package:route_shuffle/features/map/data/services/map_service.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_response.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final GeolocationService _geolocationService;
  final MapService _mapService;

  MapRepositoryImpl({
    required GeolocationService geolocationService,
    required MapService mapService,
  })  : _mapService = mapService,
        _geolocationService = geolocationService;

  @override
  FutureResult<Coordinates> getCurrentLocation() async {
    try {
      final coordinates = await _geolocationService.getCurrentLocation();
      return success(coordinates);
    } on GeolocationException catch (e) {
      return error(GeoFailure(message: e.message, error: e.failure));
    }
  }

  @override
  FutureResult<GeocodingResponse> reverseGeocode(
    Coordinates coordinates,
  ) async {
    try {
      final data = await _mapService.reverseGeocode(coordinates);
      return success(data);
    } on ApiException catch (e) {
      return error(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  FutureResult<Stream<Coordinates>> watchCurrentLocation() async {
    try {
      final stream = await _geolocationService.watchCurrentLocation();
      return success(stream);
    } on GeolocationException catch (e) {
      return error(GeoFailure(message: e.message, error: e.failure));
    }
  }

  @override
  FutureResult<List<Place>> autocompletePlaces(String input) async {
    try {
      final places = await _mapService.autocompletePlaces(input);
      return success(places);
    } on ApiException catch (e) {
      return error(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
