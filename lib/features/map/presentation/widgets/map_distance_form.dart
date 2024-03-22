import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/distance_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/map_distance_notifier.dart';
import 'package:route_shuffle/features/map/presentation/providers/unit_system_provider.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_text_field.dart';

class MapDistanceForm extends HookConsumerWidget {
  const MapDistanceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final distance = ref.read(mapDistanceNotifierProvider);
    final distanceNotifier = ref.read(mapDistanceNotifierProvider.notifier);

    final controller = useTextEditingController(text: '${distance}km');

    final unitSystem = ref.watch(unitSystemProvider);
    ref.listen(unitSystemProvider, (previous, next) {
      controller
        ..text = controller.text.replaceAll(
          RegExp(r'[a-zA-Z]{2}$'),
          next.distanceUnit,
        )
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length - 2),
        );
    });

    final distanceFocusNode = ref.watch(distanceFocusNodeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Distance',
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return MapTextField(
                      focusNode: distanceFocusNode,
                      controller: controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onTap: () =>
                          controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length - 2),
                      ),
                      onChanged: (value) {
                        final text = value.trim();
                        if (text.isNotEmpty) {
                          final distance = int.tryParse(text);
                          if (distance != null) {
                            controller
                              ..text = '$distance${unitSystem.distanceUnit}'
                              ..selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: controller.text.length - 2,
                                ),
                              );
                            distanceNotifier.change(distance);
                          }
                        } else {
                          controller
                            ..text = '1${unitSystem.distanceUnit}'
                            ..selection = TextSelection.fromPosition(
                              TextPosition(offset: controller.text.length - 2),
                            );
                          distanceNotifier.change(1);
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
