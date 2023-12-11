import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';

Logger _logger = Logger(
  filter: ProductionFilter(),
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    colors: false,
    lineLength: 100,
    printEmojis: false,
    // printTime: true,
    excludeBox: {
      Level.info: true,
      Level.warning: true,
    },
  ),
  level: Level.info,
  output: MultiOutput([
    ConsoleOutput(),
    MyFileOutput(
      file: File('log.txt'),
      overrideExisting: true,
    ),
  ]),
);
Logger get logger => _logger;

/// Writes the log output to a file.
class MyFileOutput extends LogOutput {
  final File file;
  final bool overrideExisting;
  final Encoding encoding;
  IOSink? _sink;

  MyFileOutput({
    required this.file,
    this.overrideExisting = false,
    this.encoding = utf8,
  });

  @override
  Future<void> init() async {
    _sink = file.openWrite(
      mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  @override
  void output(OutputEvent event) {
    _sink?.writeAll(event.lines, '\n');
    _sink?.writeln();
  }

  @override
  Future<void> destroy() async {
    await _sink?.flush();
    await _sink?.close();
  }
}
