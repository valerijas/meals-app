import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meals_app/main.dart';
import 'package:meals_app/services/favorite_recipes.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a FavoriteRecipes instance for testing.
    final favoriteRecipes = FavoriteRecipes();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(favoriteRecipes: favoriteRecipes));

    // Your existing test code...
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
