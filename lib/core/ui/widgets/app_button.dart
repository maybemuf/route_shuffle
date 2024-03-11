import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double height;
  final double width;
  final Color? backgroundColor;

  const AppButton({
    required this.child,
    required this.onPressed,
    this.height = 50,
    this.width = 50,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        padding: EdgeInsets.zero,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
