import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/route_type.dart';
import 'package:route_shuffle/features/map/presentation/providers/distance_focus_node_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/route_type_provider.dart';
import 'package:route_shuffle/features/map/presentation/providers/unit_system_provider.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_distance_form.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_radio_button.dart';

class MapRouteSettingsRow extends HookConsumerWidget {
  const MapRouteSettingsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final routeType = ref.watch(routeTypeNotifierProvider);
    final routeTypeNotifier = ref.read(routeTypeNotifierProvider.notifier);
    return Row(
      children: [
        const Expanded(child: MapDistanceForm()),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Route type',
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
                      child: MapRadioButton(
                        value: RouteType.walk,
                        groupValue: routeType,
                        onChanged: routeTypeNotifier.change,
                        child: const Icon(
                          Icons.directions_walk,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MapRadioButton(
                        value: RouteType.run,
                        groupValue: routeType,
                        onChanged: routeTypeNotifier.change,
                        child: const Icon(
                          Icons.directions_run,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MapRadioButton(
                        value: RouteType.bike,
                        groupValue: routeType,
                        onChanged: routeTypeNotifier.change,
                        child: const Icon(
                          Icons.directions_bike,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
