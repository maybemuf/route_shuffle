import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/providers/map_api_client_provider.dart';
import 'package:route_shuffle/features/map/data/services/map_service.dart';

part 'generated/map_service_provider.g.dart';

@riverpod
MapService mapService(MapServiceRef ref) =>
    MapServiceImpl(mapDioClient: ref.watch(mapApiClientProvider));
