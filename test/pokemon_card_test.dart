import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';
import 'package:pokedex_app/core/theme/pokemon_tokens.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/pokemon_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrapWithTokens(Widget child) {
    return MaterialApp(
      home: TokensProvider(
        tokens: PokemonLightTokens(),
        child: Scaffold(body: child),
      ),
    );
  }

  const testEffect = EffectEntry(
    effect: 'Powers up Fire-type moves when HP is low.',
    language: 'en',
  );

  final testPokemon = Pokemon(
    id: '1',
    name: 'blaze',
    image: 'https://example.com/blaze.png',
    generation: 'Generation 1',
    effectEntries: [testEffect],
  );

  group('PokemonCard widget', () {
    testWidgets('shows Remove button when showAddButton is false', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          wrapWithTokens(
            PokemonCard(
              pokemon: testPokemon,
              showAddButton: false,
              onRemoveFromPokedex: () {},
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Remove'), findsOneWidget);
      });
    });

    testWidgets('calls onAddToPokedex when Add tapped', (tester) async {
      var tapped = false;
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          wrapWithTokens(
            PokemonCard(
              pokemon: testPokemon,
              showAddButton: true,
              onAddToPokedex: () => tapped = true,
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.text('Add'));
        expect(tapped, isTrue);
      });
    });

    testWidgets('displays placeholder icon when image is empty', (tester) async {
      final noImage = testPokemon.copyWith(image: '');
      await tester.pumpWidget(
        wrapWithTokens(
          PokemonCard(pokemon: noImage, showAddButton: true),
        ),
      );
      await tester.pump();
      expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);
    });

    testWidgets('fallback description when no entries', (tester) async {
      final noDesc = testPokemon.copyWith(effectEntries: []);
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          wrapWithTokens(PokemonCard(pokemon: noDesc, showAddButton: true)),
        );
        await tester.pump();
        expect(find.text('No description available'), findsOneWidget);
      });
    });

    testWidgets('shows non-English effect if English missing', (tester) async {
      final es = testPokemon.copyWith(
        effectEntries: [const EffectEntry(effect: 'Descripción en español.', language: 'es')],
      );
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          wrapWithTokens(PokemonCard(pokemon: es, showAddButton: true)),
        );
        await tester.pump();
        expect(find.text('Descripción en español.'), findsOneWidget);
      });
    });
  });
}
