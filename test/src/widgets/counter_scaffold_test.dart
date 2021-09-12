import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:river_navigator/src/widgets/counter_scaffold.dart';

extension CounterScaffoldTester on WidgetTester {
  Future<void> pumpCounter() {
    return pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CounterScaffold(title: 'Counter'),
        ),
      ),
    );
  }

  Future<void> incrementCounter(Finder page, {int times = 1}) async {
    final incrementButton = find.descendant(
      of: page,
      matching: find.byIcon(Icons.add),
    );
    for (var i = 0; i < times; i++) {
      await tap(incrementButton);
      await pump();
    }
  }
}

extension CounterFinder on Finder {
  Finder findCounter(int count) {
    return find.descendant(
      of: this,
      matching: find.text('$count'),
    );
  }
}

void main() {
  testWidgets('counter scaffold', (tester) async {
    await tester.pumpCounter();

    final counterScaffold = find.byType(CounterScaffold);

    expect(counterScaffold, findsOneWidget);

    expect(counterScaffold.findCounter(0), findsOneWidget);
    expect(counterScaffold.findCounter(1), findsNothing);

    await tester.incrementCounter(counterScaffold);
    await tester.pump();

    expect(counterScaffold.findCounter(0), findsNothing);
    expect(counterScaffold.findCounter(1), findsOneWidget);
    expect(counterScaffold.findCounter(2), findsNothing);

    await tester.incrementCounter(counterScaffold);
    await tester.pump();

    expect(counterScaffold.findCounter(1), findsNothing);
    expect(counterScaffold.findCounter(2), findsOneWidget);
    expect(counterScaffold.findCounter(3), findsNothing);
  });
}
