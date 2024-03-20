import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';
import 'package:route_shuffle/features/map/data/services/map_service.dart';
import 'package:route_shuffle/features/map/data/services/map_session_service.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final GeolocationService _geolocationService;
  final MapService _mapService;
  final MapSessionService _mapSessionService;

  MapRepositoryImpl({
    required GeolocationService geolocationService,
    required MapService mapService,
    required MapSessionService mapSessionService,
  })  : _mapService = mapService,
        _mapSessionService = mapSessionService,
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
  FutureResult<List<GeocodingResult>> reverseGeocode(
    Coordinates coordinates,
  ) async {
    try {
      final data = await _mapService.reverseGeocode(coordinates);
      return success(data);
    } on MapApiException catch (e) {
      return error(
        MapApiFailure(
          message: e.message,
          statusCode: e.statusCode,
          status: e.status,
        ),
      );
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
  FutureResult<List<PlacePrediction>> autocompletePlaces(String input) async {
    try {
      final token = await _mapSessionService.getSessionToken();
      final places = await _mapService.autocompletePlaces(
        input: input,
        sessionToken: token,
      );
      return success(places);
    } on MapApiException catch (e) {
      return error(
        MapApiFailure(
          message: e.message,
          statusCode: e.statusCode,
          status: e.status,
        ),
      );
    }
  }

  @override
  FutureResult<Place> getPlaceDetails(String placeId) async {
    try {
      final token = await _mapSessionService.getSessionToken();
      final place = await _mapService.getPlaceDetails(
        placeId: placeId,
        sessionToken: token,
      );
      await _mapSessionService.invalidateSessionToken();

      return success(place);
    } on MapApiException catch (e) {
      return error(
        MapApiFailure(
          message: e.message,
          statusCode: e.statusCode,
          status: e.status,
        ),
      );
    }
  }
}
