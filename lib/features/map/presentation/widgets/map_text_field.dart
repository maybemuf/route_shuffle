import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_shuffle/features/map/presentation/providers/unit_system_provider.dart';

class MapTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextAlign textAlign;
  final String? hintText;
  final bool isDistance;
  final UnitSystemType unitSystemType;

  const MapTextField({
    required this.focusNode,
    required this.controller,
    this.textAlign = TextAlign.start,
    this.isDistance = false,
    this.unitSystemType = UnitSystemType.metric,
    this.hintText,
    super.key,
  });

  @override
  State<MapTextField> createState() => _MapTextFieldState();
}

class _MapTextFieldState extends State<MapTextField> {
  @override
  void didUpdateWidget(covariant MapTextField oldWidget) {
    if (oldWidget.unitSystemType != widget.unitSystemType) {
      widget.controller
          ..text = widget.controller.text.replaceAll(
            RegExp(r'[a-zA-Z]{2}$'),
            widget.unitSystemType.distanceUnit,
          )
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length - 2),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      inputFormatters: [
        if (widget.isDistance)
          FilteringTextInputFormatter.digitsOnly
        else
          FilteringTextInputFormatter.singleLineFormatter,
      ],
      textInputAction: TextInputAction.done,
      keyboardType:
          widget.isDistance ? TextInputType.number : TextInputType.text,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      onTap: () {
        if (widget.isDistance) {
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length - 2),
          );
        }
      },
      onChanged: (value) {
        if (widget.isDistance) {
          final text = value.trim();
          if (text.isNotEmpty) {
            final distance = int.tryParse(text);
            if (distance != null) {
              widget.controller
                ..text = '$distance${widget.unitSystemType.distanceUnit}'
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length - 2),
                );
            }
          } else {
            widget.controller
              ..text = '1${widget.unitSystemType.distanceUnit}'
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length - 2),
              );
          }
        }
      },
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
