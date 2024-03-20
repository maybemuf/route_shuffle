import 'package:dio/dio.dart';
import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/network/dio_client.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_response.dart';
import 'package:route_shuffle/features/map/domain/entities/place.dart';

abstract interface class MapService {
  Future<GeocodingResponse> reverseGeocode(Coordinates coordinates);

  Future<GeocodingResponse> geocode(String address);

  Future<List<Place>> autocompletePlaces(String input);
}

class MapServiceImpl implements MapService {
  final DioClient dioClient;

  MapServiceImpl({required this.dioClient});

  @override
  Future<GeocodingResponse> reverseGeocode(Coordinates coordinates) async {
    try {
      final response = await dioClient.get(
        '/geocode/json',
        queryParameters: {
          'latlng': '${coordinates.lat},${coordinates.lng}',
          'location_type': 'ROOFTOP|APPROXIMATE',
        },
      );

      return GeocodingResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Something went wrong',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<GeocodingResponse> geocode(String address) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> autocompletePlaces(String input) {
    throw UnimplementedError();
  }
}
