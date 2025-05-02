import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_bootstrap.dart';
import '../exceptions/async_error_logger.dart';

extension AppBootstrapApi on AppBootstrap {
  Future<ProviderContainer> createApiProviderContainer({List<Override> overrides = const []}) async {
    return ProviderContainer(
      observers: [AsyncErrorLogger()],
      overrides: overrides,
    );
  }
}