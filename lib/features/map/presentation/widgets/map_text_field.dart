import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextAlign textAlign;
  final String? hintText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const MapTextField({
    required this.focusNode,
    required this.controller,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hintText,
    this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  State<MapTextField> createState() => _MapTextFieldState();
}

class _MapTextFieldState extends State<MapTextField> {
  @override
  void didUpdateWidget(covariant MapTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: widget.hintText,
        border: getInputBorder(context),
        enabledBorder: getInputBorder(context),
        focusedBorder: getInputBorder(context),
        errorBorder: getInputBorder(context),
        focusedErrorBorder: getInputBorder(context),
      ),
    );
  }

  OutlineInputBorder getInputBorder(BuildContext context) {
    return OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
