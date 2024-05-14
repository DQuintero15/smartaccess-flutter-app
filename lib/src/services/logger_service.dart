import 'package:logging/logging.dart';

class LoggerService {
  final String _tag;

  LoggerService(this._tag);

  void log(String message) {
    Logger.root.log(Level.INFO, '$_tag: $message');
  }

  void error(String message) {
    Logger.root.log(Level.SEVERE, '$_tag: $message');
  }
}
