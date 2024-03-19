import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/unit_system_provider.g.dart';

enum UnitSystemType { imperial, metric }

extension UnitSystemTypeX on UnitSystemType {
  bool get isImperial => this == UnitSystemType.imperial;

  bool get isMetric => this == UnitSystemType.metric;

  String get distanceUnit => isMetric ? 'km' : 'mi';
}

@riverpod
class UnitSystem extends _$UnitSystem {
  @override
  UnitSystemType build() {
    return UnitSystemType.metric;
  }

  void toggle() =>
      state = state.isMetric ? UnitSystemType.imperial : UnitSystemType.metric;
}
