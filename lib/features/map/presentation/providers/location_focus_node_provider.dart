import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationFocusNodeProvider = Provider<FocusNode>((ref) {
  final focusNode = FocusNode();
  ref.onDispose(focusNode.dispose);

  return focusNode;
});
