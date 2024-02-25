import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/data/services/geolocation_service.dart';

part 'generated/geolocation_service_provider.g.dart';

@riverpod
GeolocationService geolocationService(GeolocationServiceRef ref) =>
    GeolocationServiceImpl();
