import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const String _sessionTokenKey = 'google_maps_session_token';
const String _lastTimeTokenSetKey = 'google_maps_last_time_token_set';

abstract interface class MapSessionService {
  Future<String> getSessionToken();

  Future<void> invalidateSessionToken();
}

class MapSessionServiceImpl implements MapSessionService {
  final FlutterSecureStorage secureStorage;

  MapSessionServiceImpl({
    required this.secureStorage,
  });

  @override
  Future<String> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await secureStorage.read(key: _sessionTokenKey);

    // If token is null or expired, generate a new one
    if (token == null || !await _isSessionTokenValid()) {
      final newToken = const Uuid().v4();
      await secureStorage.write(key: _sessionTokenKey, value: newToken);

      await prefs.setString(
        _lastTimeTokenSetKey,
        DateTime.now().toIso8601String(),
      );

      return newToken;
    }

    return token;
  }

  @override
  Future<void> invalidateSessionToken() async {
    await secureStorage.delete(key: _sessionTokenKey);
  }

  Future<bool> _isSessionTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final lastTimeTokenSet = prefs.getString(_lastTimeTokenSetKey);
    if (lastTimeTokenSet == null) return false;

    final lastTime = DateTime.parse(lastTimeTokenSet);
    final now = DateTime.now();

    return now.difference(lastTime).inMinutes < 5;
  }
}
