import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/location_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/location_text_controller_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/notifiers/place_notifier/places_notifier.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_text_field.dart';

class MapLocationRow extends HookConsumerWidget {
  const MapLocationRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final isFocus = useState(false);
    final locationFocusNode = ref.read(locationFocusNodeProvider);
    locationFocusNode.addListener(() {
      isFocus.value = locationFocusNode.hasFocus;
    });

    final controller = ref.watch(locationTextControllerProvider);
    final notifier = ref.read(placesNotifierProvider.notifier);
    final isLoading = ref.watch(
      placesNotifierProvider.select((state) => state.isLoading),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Starting Location',
          textScaler: TextScaler.noScaling,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    MapTextField(
                      hintText: 'Starting Location',
                      focusNode: locationFocusNode,
                      controller: controller,
                      onTap: () {
                        controller.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: controller.text.length,
                        );
                      },
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          return;
                        }
                        await notifier.fetchPlaces(
                          value,
                          onError: (error) {
                            //TODO: Handle error
                          },
                        );
                      },
                      trailing: isFocus.value
                          ? isLoading
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    controller.clear();
                                    notifier.clearPlaces();
                                  },
                                )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              MapActionButton(
                height: 50,
                width: 50,
                onPressed: () {},
                child: const Icon(Icons.pin_drop),
              ),
              const SizedBox(width: 10),
              MapActionButton(
                height: 50,
                width: 50,
                onPressed: () {},
                child: const Icon(Icons.my_location),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
