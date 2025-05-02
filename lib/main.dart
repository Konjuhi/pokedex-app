import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_bootstrap.dart';
import 'core/extensions/app_api_extension.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appBootstrap = AppBootstrap();

  final overrides = <Override>[];

  // assert(() {
  //   overrides.add(pokemonApiProvider.overrideWithValue(FailingPokemonApi()));
  //   return true;
  // }());b

  final container = await appBootstrap.createApiProviderContainer(
    overrides: overrides,
  );

  runApp(appBootstrap.createRootWidget(container: container));
}
