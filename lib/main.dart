import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_bootstrap.dart';
import 'core/api/fake_pokemon_failing_api.dart';
import 'core/extensions/app_api_extension.dart';
import 'core/api/pokemon_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appBootstrap = AppBootstrap();

  final overrides = <Override>[];

  // assert(() {
  //   overrides.add(pokemonApiProvider.overrideWithValue(FailingPokemonApi()));
  //   return true;
  // }());

  final container = await appBootstrap.createApiProviderContainer(
    overrides: overrides,
  );

  runApp(appBootstrap.createRootWidget(container: container));
}
