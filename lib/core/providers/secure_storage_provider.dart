import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) =>
    const FlutterSecureStorage();
