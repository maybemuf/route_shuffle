import 'package:logger/logger.dart';

final logger  = Logger(
  printer: PrettyPrinter(),
  filter: ProductionFilter(),
  output: ConsoleOutput(),
);
