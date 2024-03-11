import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_shuffle/features/map/presentation/widgets/map_action_block.dart';

class MapBottomSheet extends HookWidget {
  final double height;

  const MapBottomSheet({
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final topPadding = MediaQuery.paddingOf(context).top;
        final bottomSheetHeight = constraints.maxHeight - topPadding;
        final minChildSize = height / constraints.maxHeight;
        final maxChildSize = bottomSheetHeight / constraints.maxHeight;
        return DraggableScrollableSheet(
          initialChildSize: minChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          snap: true,
          builder: (context, scrollController) {
            return ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: bottomSheetHeight,
                  child: Column(
                    children: [
                      const MapActionBlock(),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Item $index'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
