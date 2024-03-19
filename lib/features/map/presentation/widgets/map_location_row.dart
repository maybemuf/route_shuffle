import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/location_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_text_field.dart';

class MapLocationRow extends HookConsumerWidget {
  const MapLocationRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationFocusNode = ref.read(locationFocusNodeProvider);
    final controller = useTextEditingController(text: 'Current Location');
    final textTheme = Theme.of(context).textTheme;
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
                child: MapTextField(
                  hintText: 'Starting Location',
                  focusNode: locationFocusNode,
                  controller: controller,
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
