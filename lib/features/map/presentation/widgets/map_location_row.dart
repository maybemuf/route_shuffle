import 'package:flutter/material.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';

class MapLocationRow extends StatelessWidget {
  const MapLocationRow({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return MapActionButton(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      onPressed: () {},
                      child: SizedBox(
                        width: constraints.maxWidth - 24,
                        child: Text(
                          'Starting Location',
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
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
