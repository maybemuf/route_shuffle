import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/core/providers/secure_storage_provider.dart';
import 'package:route_shuffle/features/map/data/services/map_session_service.dart';

part 'generated/map_session_service_provider.g.dart';

@riverpod
MapSessionService mapSessionService(MapSessionServiceRef ref) =>
    MapSessionServiceImpl(secureStorage: ref.watch(secureStorageProvider));
