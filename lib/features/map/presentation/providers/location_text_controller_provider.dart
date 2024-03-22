import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationTextControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
