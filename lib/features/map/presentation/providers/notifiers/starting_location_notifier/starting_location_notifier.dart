// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:route_shuffle/features/map/presentation/providers/location_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/location_text_controller_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/starting_location_notifier/starting_location.dart';

part 'generated/starting_location_notifier.g.dart';

@riverpod
class StartingLocationNotifier extends _$StartingLocationNotifier {
  @override
  StartingLocation? build() {
    return null;
  }

  void setStartingLocation(StartingLocation location) {
    ref.read(locationTextControllerProvider).text = location.address;
    ref.read(locationFocusNodeProvider).unfocus();
    state = location;
  }
}
