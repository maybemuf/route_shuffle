import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_shuffle/core/utils/utility_functions.dart';

class MapTopBar extends HookWidget {
  final DraggableScrollableController dragController;
  final double bottomSheetFraction;
  final double height;

  const MapTopBar({
    required this.dragController,
    this.bottomSheetFraction = .3,
    this.height = 100,
    super.key,
  }) : assert(
          bottomSheetFraction > 0 && bottomSheetFraction < 1,
          'bottomSheetFraction must be between 0 and 1',
        );

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final position = useState<Offset>(Offset(0, -height - topPadding));

    useEffect(
      () {
        dragController.addListener(() {
          final pixels = dragController.pixels;
          final dragPercent = valueToPercentage(
            pixels,
            screenHeight * bottomSheetFraction,
            screenHeight * (1 - bottomSheetFraction),
          );
          final yOffset = percentageToValue(
            dragPercent,
            -height - topPadding,
            0,
          );
          position.value = Offset(0, yOffset);
        });
        return dragController.dispose;
      },
      [dragController],
    );

    return Transform.translate(
      offset: position.value,
      child: Container(
        height: topPadding + height,
        width: double.infinity,
        color: Colors.greenAccent.withOpacity(.5),
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              dragController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ),
    );
  }
}
