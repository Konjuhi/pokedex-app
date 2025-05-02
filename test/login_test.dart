import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets(
    'Login screen has username and password fields and a login button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Pokédex Login'), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);

      expect(find.byType(TextField), findsNWidgets(2));

      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

      expect(find.text('Default login: user / password'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));
    },
  );
}
