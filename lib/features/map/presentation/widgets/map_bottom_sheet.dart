import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/providers/distance_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/is_bottom_sheet_expanded_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/unit_system_provider.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_block.dart';

class MapBottomSheet extends HookConsumerWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeightWithoutTop =
        MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).top;
    final key = useMemoized(GlobalKey.new);
    final isExpanded = useState(false);
    final height = useState(0.0);

    ref.listen(isBottomSheetExpandedProvider, (previous, next) {
      final blockHeight = key.currentContext?.size?.height ?? 0;
      final heightToExpand = screenHeightWithoutTop - blockHeight;
      if (!next) {
        isExpanded.value = false;
      }
      height.value = next ? heightToExpand : 0;
    });

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        constraints: BoxConstraints(maxHeight: screenHeightWithoutTop),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MapActionBlock(key: key),
            if (!isExpanded.value)
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            if (isExpanded.value)
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                    ),
                    if (ref.watch(distanceFocusNodeProvider).hasFocus)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
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
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            else
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: height.value,
                onEnd: () {
                  isExpanded.value = ref.read(isBottomSheetExpandedProvider);
                },
                child: const SizedBox(),
              ),
            SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
          ],
        ),
      ),
    );
  }
}
