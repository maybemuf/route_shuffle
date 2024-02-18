import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/app_init_provider.g.dart';

@riverpod
Future<void> appInit(AppInitRef ref) async {
  ref.onDispose(() {});

  await Future.delayed(const Duration(seconds: 1), () {});
}
