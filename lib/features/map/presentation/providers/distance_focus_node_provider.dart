import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final distanceFocusNodeProvider = Provider<FocusNode>((ref) {
  final focusNode = FocusNode();
  ref.onDispose(focusNode.dispose);

  return focusNode;
});
