import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/data/repositories/map_repository_impl.dart';
import 'package:route_shuffle/features/map/domain/providers/geolocation_service_provider.dart';
import 'package:route_shuffle/features/map/domain/providers/map_service_provider.dart';
import 'package:route_shuffle/features/map/domain/repositories/map_repository.dart';

part 'generated/map_repository_provider.g.dart';

@riverpod
MapRepository mapRepository(MapRepositoryRef ref) => MapRepositoryImpl(
      mapService: ref.watch(mapServiceProvider),
      geolocationService: ref.watch(geolocationServiceProvider),
    );
