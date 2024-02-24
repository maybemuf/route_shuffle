import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:route_shuffle/core/errors/enums.dart';
import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/errors/failure.dart';
import 'package:route_shuffle/core/models/api_result.dart';
import 'package:route_shuffle/features/map/data/repositories/map_repository_impl.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

@GenerateNiceMocks([MockSpec<GeolocationService>()])
import 'map_repository_impl_test.mocks.dart';

void main() {
  late GeolocationService geolocationService;
  late MapRepository mapRepositoryImpl;

  setUp(() {
    geolocationService = MockGeolocationService();
    mapRepositoryImpl = MapRepositoryImpl(
      geolocationService: geolocationService,
    );
  });

  group('geolocation service', () {
    test('should return coordinates on success', () async {
      //arrange
      const tCoords = Coordinates(latitude: 0, longitude: 0);
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
}
