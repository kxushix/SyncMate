import 'package:syncmate/core/logger/log_event.dart';

abstract class LogSink {
  void log(LogEvent event);
}
