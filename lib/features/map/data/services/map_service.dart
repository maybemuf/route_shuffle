import 'package:dio/dio.dart';
import 'package:route_shuffle/core/errors/exceptions.dart';
import 'package:route_shuffle/core/network/dio_client.dart';
import 'package:route_shuffle/features/map/data/models/autocomplete_response.dart';
import 'package:route_shuffle/features/map/data/models/enums/map_api_response_status.dart';
import 'package:route_shuffle/features/map/data/models/geocoding_response.dart';
import 'package:route_shuffle/features/map/domain/entities/coordinates.dart';
import 'package:route_shuffle/features/map/domain/entities/geocoding_result.dart';
import 'package:route_shuffle/features/map/domain/entities/place_prediction.dart';

abstract interface class MapService {
  Future<List<GeocodingResult>> reverseGeocode(Coordinates coordinates);

  Future<List<GeocodingResult>> geocode(String address);

  Future<List<PlacePrediction>> autocompletePlaces(String input);
}

class MapServiceImpl implements MapService {
  final DioClient mapDioClient;

  MapServiceImpl({required this.mapDioClient});

  @override
  Future<List<GeocodingResult>> reverseGeocode(Coordinates coordinates) async {
    try {
      final response = await mapDioClient.get(
        '/geocode/json',
        queryParameters: {
          'latlng': '${coordinates.lat},${coordinates.lng}',
          'location_type': 'ROOFTOP|APPROXIMATE',
        },
      );

      final geocodingResponse = GeocodingResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (geocodingResponse.status.isError) {
        throw MapApiException(
          message: geocodingResponse.status.toString(),
          statusCode: 500,
          status: geocodingResponse.status,
        );
      }

      return geocodingResponse.results;

    } on DioException catch (e) {
      throw MapApiException(
        message: e.message ?? 'Something went wrong',
        statusCode: e.response?.statusCode ?? 500,
        status: MapApiResponseStatus.unknownError,
      );
    }
  }

  @override
  Future<List<GeocodingResult>> geocode(String address) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PlacePrediction>> autocompletePlaces(String input) async {
    try {
      final response = await mapDioClient.get(
        '/place/autocomplete/json',
        queryParameters: {
          'input': input,
          'types': 'address',
        },
      );

      final autoCompleteResponse = AutocompleteResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (autoCompleteResponse.status.isError) {
        throw MapApiException(
          message: autoCompleteResponse.status.toString(),
          statusCode: 500,
          status: autoCompleteResponse.status,
        );
      }

      return autoCompleteResponse.predictions;

    } on DioException catch (e) {
      throw MapApiException(
        message: e.message ?? 'Something went wrong',
        statusCode: e.response?.statusCode ?? 500,
        status: MapApiResponseStatus.unknownError,
      );
    }
  }
}
