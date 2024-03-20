import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_location_row.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_route_settings_row.dart';

class MapActionBlock extends ConsumerWidget {
  const MapActionBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const MapLocationRow(),
        const SizedBox(height: 20),
        const MapRouteSettingsRow(),
        const SizedBox(height: 20),
        MapActionButton(
          height: 50,
          onPressed: () {},
          width: double.infinity,
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(.9),
          child: Text(
            'Shuffle Route',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
