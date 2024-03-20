import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_response.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';

abstract interface class MapRepository {
  FutureResult<Coordinates> getCurrentLocation();

  FutureResult<Stream<Coordinates>> watchCurrentLocation();

  FutureResult<GeocodingResponse> reverseGeocode(Coordinates coordinates);

  FutureResult<List<Place>> autocompletePlaces(String input);
}
