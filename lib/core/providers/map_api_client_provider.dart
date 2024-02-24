import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/network/dio_client.dart';
import 'package:route_shuffle/core/utils/app_config.dart';
import 'package:route_shuffle/core/utils/constants_strings.dart';

part 'generated/map_api_client_provider.g.dart';

@riverpod
DioClient mapApiClient(MapApiClientRef ref) => DioClient(
      baseUrl: ConstantStrings.googleApi,
      key: AppConfig.googleMapApiKey,
    );
