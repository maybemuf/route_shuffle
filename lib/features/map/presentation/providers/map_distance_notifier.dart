import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/map_distance_notifier.g.dart';

@riverpod
class MapDistanceNotifier extends _$MapDistanceNotifier {
  @override
  int build() => 3;

  void change(int value) {
    state = value;
  }
}
