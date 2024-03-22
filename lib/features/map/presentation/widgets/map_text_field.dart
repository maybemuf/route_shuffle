import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextAlign textAlign;
  final String? hintText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? trailing;

  const MapTextField({
    required this.focusNode,
    required this.controller,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              inputFormatters: inputFormatters,
              textInputAction: TextInputAction.done,
              keyboardType: keyboardType,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: textAlign,
              textAlignVertical: TextAlignVertical.center,
              onTap: onTap,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hintText: hintText,
                border: getInputBorder(context),
                enabledBorder: getInputBorder(context),
                focusedBorder: getInputBorder(context),
                errorBorder: getInputBorder(context),
                focusedErrorBorder: getInputBorder(context),
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            trailing!,
          ],
        ],
      ),
    );
  }

  OutlineInputBorder getInputBorder(BuildContext context) {
    return const OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none);
  }
}
