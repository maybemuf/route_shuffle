import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:route_shuffle/core/errors/enums.dart';
import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';
import 'package:route_shuffle/features/map/data/repositories/map_repository_impl.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';
import 'package:route_shuffle/features/map/data/services/map_service.dart';
import 'package:route_shuffle/features/map/data/services/map_session_service.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';
import 'package:route_shuffle/features/map/domain/entities/geolocation_geometry.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';
import 'package:route_shuffle/features/map/domain/providers/map_session_service_provider.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

@GenerateNiceMocks([
  MockSpec<GeolocationService>(),
  MockSpec<MapService>(),
  MockSpec<MapSessionService>(),
])
import 'map_repository_impl_test.mocks.dart';

void main() {
  late GeolocationService geolocationService;
  late MapService mapService;
  late MapRepository mapRepositoryImpl;
  late MapSessionService mapSessionService;

  setUp(() {
    geolocationService = MockGeolocationService();
    mapService = MockMapService();
    mapSessionService = MockMapSessionService();
    mapRepositoryImpl = MapRepositoryImpl(
      geolocationService: geolocationService,
      mapService: mapService,
      mapSessionService: mapSessionService,
    );
  });

  group('geolocation service', () {
    test('should return coordinates on success', () async {
      //arrange
      const tCoords = Coordinates(lat: 0, lng: 0);
      when(geolocationService.getCurrentLocation())
          .thenAnswer((_) async => tCoords);

      //act
      final result = await mapRepositoryImpl.getCurrentLocation();

      //assert
      expect(result.isSuccess, equals(true));
      expect(result.success, equals(tCoords));
    });

    test('should throw [GeoFailureError.serviceDisabled]', () async {
      //arrange
      final tException = GeolocationException(
        message: 'Location services are disabled',
        failure: GeoFailureError.serviceDisabled,
      );
      final tFailure = GeoFailure(
        message: tException.message,
        error: tException.failure,
      );
      when(geolocationService.getCurrentLocation()).thenThrow(tException);

      //act
      final result = await mapRepositoryImpl.getCurrentLocation();

      //assert
      expect(result.isError, equals(true));
      expect(result.error, equals(tFailure));
    });

    test('should throw [GeoFailureError.permissionDenied]', () async {
      //arrange
      final tException = GeolocationException(
        message: 'Location services are disabled',
        failure: GeoFailureError.permissionDenied,
      );
      final tFailure = GeoFailure(
        message: tException.message,
        error: tException.failure,
      );
      when(geolocationService.getCurrentLocation()).thenThrow(tException);

      //act
      final result = await mapRepositoryImpl.getCurrentLocation();

      //assert
      expect(result.isError, equals(true));
      expect(result.error, equals(tFailure));
    });

    test('should throw [GeoFailureError.permissionDeniedForever]', () async {
      //arrange
      final tException = GeolocationException(
        message: 'Location services are disabled',
        failure: GeoFailureError.permissionDeniedForever,
      );
      final tFailure = GeoFailure(
        message: tException.message,
        error: tException.failure,
      );
      when(geolocationService.getCurrentLocation()).thenThrow(tException);

      //act
      final result = await mapRepositoryImpl.getCurrentLocation();

      //assert
      expect(result.isError, equals(true));
      expect(result.error, equals(tFailure));
    });
  });

  group('geocoding service', () {
    group('reverse geocoding', () {
      test('should return geocoding response on success', () async {
        //arrange
        const tCoords = Coordinates(lat: 0, lng: 0);
        const tResults = <GeocodingResult>[];
        when(mapService.reverseGeocode(tCoords))
            .thenAnswer((_) async => tResults);

        //act
        final result = await mapRepositoryImpl.reverseGeocode(tCoords);

        //assert
        expect(result.isSuccess, equals(true));
        expect(result.success, equals(tResults));
      });

      test('should throw [ApiFailure] on [ApiException]', () async {
        //arrange
        final tException = MapApiException(
          message: 'Api error',
          statusCode: 404,
          status: MapApiResponseStatus.unknownError,
        );
        final tFailure = MapApiFailure(
          message: tException.message,
          statusCode: tException.statusCode,
          status: tException.status,
        );
        const tCoords = Coordinates(lat: 0, lng: 0);
        when(mapService.reverseGeocode(tCoords)).thenThrow(tException);

        //act
        final result = await mapRepositoryImpl.reverseGeocode(tCoords);

        //assert
        expect(result.isError, equals(true));
        expect(result.error, equals(tFailure));
      });
    });
  });

  group('places autocomplete', () {
    const tInput = 'input';
    const tToken = 'token';
    test('should succeed with [List<Place>] on success', () async {
      const tPlaces = <PlacePrediction>[];
      when(
        mapService.autocompletePlaces(
          input: tInput,
          sessionToken: tToken,
        ),
      ).thenAnswer((_) async => tPlaces);

      //act
      final result = await mapRepositoryImpl.autocompletePlaces(tInput);

      //assert
      expect(result.isSuccess, equals(true));
      expect(result.success, equals(tPlaces));
    });

    test('should throw [ApiFailure] on [ApiException]', () async {
      //arrange
      final tException = MapApiException(
        message: 'Api error',
        statusCode: 404,
        status: MapApiResponseStatus.unknownError,
      );
      final tFailure = MapApiFailure(
        message: tException.message,
        statusCode: tException.statusCode,
        status: tException.status,
      );
      when(mapSessionService.getSessionToken()).thenAnswer((_) async => tToken);
      when(
        mapService.autocompletePlaces(
          input: tInput,
          sessionToken: tToken,
        ),
      ).thenThrow(tException);

      //act
      final result = await mapRepositoryImpl.autocompletePlaces(tInput);
      print(result);
      //assert
      expect(result.isError, equals(true));
      expect(result.error, equals(tFailure));
    });
  });

  group('place details', () {
    const tPlaceId = 'placeId';
    const tToken = 'token';
    test('should succeed with [Place] on success', () async {
      const tPlace = Place(
        formattedAddress: 'formattedAddress',
        geometry: GeolocationGeometry(location: Coordinates(lat: 0, lng: 0)),
      );
      when(mapSessionService.invalidateSessionToken()).thenAnswer((_) async {});
      when(mapSessionService.getSessionToken()).thenAnswer((_) async => tToken);
      when(
        mapService.getPlaceDetails(
          placeId: tPlaceId,
          sessionToken: tToken,
        ),
      ).thenAnswer((_) async => tPlace);

      //act
      final result = await mapRepositoryImpl.getPlaceDetails(tPlaceId);

      //assert
      expect(result.isSuccess, equals(true));
      expect(result.success, equals(tPlace));
    });

    test('should throw [ApiFailure] on [ApiException]', () async {
      //arrange
      final tException = MapApiException(
        message: 'Api error',
        statusCode: 404,
        status: MapApiResponseStatus.unknownError,
      );
      final tFailure = MapApiFailure(
        message: tException.message,
        statusCode: tException.statusCode,
        status: tException.status,
      );
      when(mapSessionService.invalidateSessionToken()).thenAnswer((_) async {});
      when(mapSessionService.getSessionToken()).thenAnswer((_) async => tToken);
      when(
        mapService.getPlaceDetails(
          placeId: tPlaceId,
          sessionToken: tToken,
        ),
      ).thenThrow(tException);

      //act
      final result = await mapRepositoryImpl.getPlaceDetails(tPlaceId);

      //assert
      expect(result.isError, equals(true));
      expect(result.error, equals(tFailure));
    });
  });
}
