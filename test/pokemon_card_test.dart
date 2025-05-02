import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/core/models/pokemon.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/pokemon_card.dart';

class MockNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, String) placeholder;
  final Widget Function(BuildContext, String, dynamic) errorWidget;
  final BoxFit? fit;

  const MockNetworkImage({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.errorWidget,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return placeholder(context, imageUrl);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestableWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  final testPokemon = Pokemon(
    id: '1',
    name: 'blaze',
    image: 'https://example.com/blaze.png',
    generation: 'Generation 1',
    effectEntries: [
      const EffectEntry(
        effect: 'Powers up Fire-type moves when HP is low.',
        language: 'en',
      ),
    ],
  );

  testWidgets(
    'PokemonCard displays Remove button when showAddButton is false',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          PokemonCard(
            pokemon: testPokemon,
            showAddButton: false,
            onRemoveFromPokedex: () {},
          ),
        ),
      );

      expect(find.text('Remove'), findsOneWidget);
    },
  );

  testWidgets('PokemonCard calls onAddToPokedex when Add button is tapped', (
    WidgetTester tester,
  ) async {
    bool addButtonTapped = false;

    await tester.pumpWidget(
      createTestableWidget(
        PokemonCard(
          pokemon: testPokemon,
          showAddButton: true,
          onAddToPokedex: () {
            addButtonTapped = true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(addButtonTapped, true);
  });

  testWidgets('PokemonCard shows placeholder when image is empty', (
    WidgetTester tester,
  ) async {
    final pokemonWithoutImage = testPokemon.copyWith(image: '');

    await tester.pumpWidget(
      createTestableWidget(
        PokemonCard(pokemon: pokemonWithoutImage, showAddButton: true),
      ),
    );

    expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);
  });

  testWidgets('PokemonCard handles fallback for missing effect entries', (
    WidgetTester tester,
  ) async {
    final pokemonWithoutDescriptions = testPokemon.copyWith(effectEntries: []);

    await tester.pumpWidget(
      createTestableWidget(
        PokemonCard(pokemon: pokemonWithoutDescriptions, showAddButton: true),
      ),
    );

    expect(find.text('No description available'), findsOneWidget);
  });

  testWidgets('PokemonCard handles non-English effect entries', (
    WidgetTester tester,
  ) async {
    final pokemonWithNonEnglishDescription = testPokemon.copyWith(
      effectEntries: [
        const EffectEntry(
          effect: 'Aumenta los movimientos tipo fuego cuando la salud es baja.',
          language: 'es',
        ),
      ],
    );

    await tester.pumpWidget(
      createTestableWidget(
        PokemonCard(
          pokemon: pokemonWithNonEnglishDescription,
          showAddButton: true,
        ),
      ),
    );

    expect(
      find.text('Aumenta los movimientos tipo fuego cuando la salud es baja.'),
      findsOneWidget,
    );
  });
}
