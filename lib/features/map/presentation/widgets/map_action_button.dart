import 'package:flutter/material.dart';
import 'package:route_shuffle/core/ui/widgets/app_button.dart';

class MapActionButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const MapActionButton({
    required this.child,
    required this.height,
    required this.width,
    this.backgroundColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: height,
      width: width,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
