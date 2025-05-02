import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_exception.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    log('$error, $stackTrace');
  }

  void logAppException(AppException exception) {
    log('$exception');
  }
}

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
} 