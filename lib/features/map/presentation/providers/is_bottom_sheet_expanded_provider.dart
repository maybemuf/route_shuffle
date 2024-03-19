// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/presentation/providers/distance_focus_node_provider.dart';

import 'package:route_shuffle/features/map/presentation/providers/location_focus_node_provider.dart';

part 'generated/is_bottom_sheet_expanded_provider.g.dart';

@riverpod
class IsBottomSheetExpanded extends _$IsBottomSheetExpanded {
  bool _isLocationFocusNodeHasFocus = false;
  bool _isDistanceFocusNodeHasFocus = false;

  @override
  bool build() {
    final locationFocusNode = ref.watch(locationFocusNodeProvider);
    final distanceFocusNode = ref.watch(distanceFocusNodeProvider);

    locationFocusNode.addListener(() {
      _isLocationFocusNodeHasFocus = locationFocusNode.hasFocus;
      Future.delayed(Duration.zero, () {
        state = _isLocationFocusNodeHasFocus || _isDistanceFocusNodeHasFocus;
      });
    });

    distanceFocusNode.addListener(() {
      _isDistanceFocusNodeHasFocus = distanceFocusNode.hasFocus;
      Future.delayed(Duration.zero, () {
        state = _isLocationFocusNodeHasFocus || _isDistanceFocusNodeHasFocus;
      });
    });

    return _isLocationFocusNodeHasFocus || _isDistanceFocusNodeHasFocus;
  }

  void toggle() => state = !state;

  void expand() => state = true;

  void collapse() => state = false;
}
