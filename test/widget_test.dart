import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:river_navigator/main.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(const ProviderScope(child: RiverNavigatorApp()));
  }
}

void main() {
  testWidgets('Page1 counter increments', (WidgetTester tester) async {
    await tester.pumpApp();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsNothing);
  });

  group('From Page1 to Page2', () {
    testWidgets('Go to Page3, pop and pop must go to Page1',
        (WidgetTester tester) async {
      await tester.pumpApp();

      final goToFlowButton = find.byType(ElevatedButton);

      await tester.tap(goToFlowButton);
    });

    testWidgets('Replace to Page3 and pop must go to Page1',
        (WidgetTester tester) async {
      tester.pumpApp();
    });
  });
}
