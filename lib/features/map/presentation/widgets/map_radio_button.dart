import 'package:flutter/material.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_button.dart';

class MapRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function() onChanged;
  final Widget child;

  const MapRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MapActionButton(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          onPressed: onChanged,
          backgroundColor: value == groupValue
              ? Theme.of(context).colorScheme.primary.withOpacity(.2)
              : null,
          child: child,
        );
      },
    );
  }
}
