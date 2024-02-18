import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/core/utils/logger.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      logger.i('''
    {
      "event": "didAddProvider",
      "provider": "${provider.name}",
      "value": "$value"
    }
    ''');

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      logger.i('''
    {
      "event": "didDisposeProvider",
      "provider": "${provider.name}"
    }
    ''');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      logger.i('''
    {
      "event": "didUpdateProvider",
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }
    ''');
}
