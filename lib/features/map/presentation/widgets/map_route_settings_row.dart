import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_shuffle/features/map/domain/entities/enums/route_type.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_radio_button.dart';

class MapRouteSettingsRow extends HookWidget {
  const MapRouteSettingsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final routeType = useState<RouteType>(RouteType.walk);

    return Row(
      children: [
        Expanded(
          child: Column(
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
                          print(
                              'constraints.maxWidth: ${constraints.maxWidth}');
                          return MapActionButton(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            onPressed: () {},
                            child: Text(
                              '3 km',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                        groupValue: routeType.value,
                        onChanged: () => routeType.value = RouteType.walk,
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
                        groupValue: routeType.value,
                        onChanged: () => routeType.value = RouteType.run,
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
                        groupValue: routeType.value,
                        onChanged: () => routeType.value = RouteType.bike,
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
