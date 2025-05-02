import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'my_app.dart';

class AppBootstrap {
  Widget createRootWidget({required ProviderContainer container}) {
    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }
}
