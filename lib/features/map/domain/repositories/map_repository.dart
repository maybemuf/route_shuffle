import 'package:route_shuffle/core/utils/typedefs.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';

abstract interface class MapRepository {
  FutureResult<Coordinates> getCurrentLocation();

  FutureResult<Stream<Coordinates>> watchCurrentLocation();

  FutureResult<List<GeocodingResult>> reverseGeocode(Coordinates coordinates);

  FutureResult<List<PlacePrediction>> autocompletePlaces(String input);

  FutureResult<Place> getPlaceDetails(String placeId);
}
