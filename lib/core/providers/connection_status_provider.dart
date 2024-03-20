import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/connection_status_provider.g.dart';

@riverpod
Stream<ConnectivityResult> connectionStatus(ConnectionStatusRef ref) async* {
  final connectivity = Connectivity();
  await for (final _ in connectivity.onConnectivityChanged) {
    yield await connectivity.checkConnectivity();
  }
}