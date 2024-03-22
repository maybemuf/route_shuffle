import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/distance_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/unit_system_provider.dart';

class UnitSystemSwitcher extends ConsumerWidget {
  const UnitSystemSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            'Use metric:',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Switch(
            value: ref.watch(unitSystemProvider).isMetric,
            inactiveTrackColor: Theme.of(context)
                .primaryColor
                .withOpacity(.5),
            onChanged: (value) {
              ref
                  .read(unitSystemProvider.notifier)
                  .toggle();
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed:
            ref.read(distanceFocusNodeProvider).unfocus,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
