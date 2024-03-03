import 'package:flutter/material.dart';

class MapBottomSheet extends StatelessWidget {
  final DraggableScrollableController dragController;
  final double bottomSheetFraction;
  const MapBottomSheet({
    required this.dragController,
    this.bottomSheetFraction = .3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: bottomSheetFraction,
      minChildSize: bottomSheetFraction,
      snap: true,
      controller: dragController,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ColoredBox(
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
          ),
        );
      },
    );
  }
}
