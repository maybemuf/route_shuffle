import 'dart:io' as io;

import 'package:logger/logger.dart';

final logger  = Logger(
  printer: PrettyPrinter(
    lineLength: io.stdout.terminalColumns,
    colors: io.stdout.supportsAnsiEscapes,
  ),
  filter: ProductionFilter(),
  output: ConsoleOutput(),
);
