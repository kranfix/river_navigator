import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:river_navigator/src/widgets/counter_scaffold.dart';

extension _CounterScaffoldTester on WidgetTester {
  Future<void> pumpCounter() {
    return pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CounterScaffold(title: 'Counter'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('counter scaffold', (tester) async {
    await tester.pumpCounter();

    final counterScaffold = find.byType(CounterScaffold);

    expect(counterScaffold, findsOneWidget);

    Finder findCount(int count) {
      return find.descendant(
        of: counterScaffold,
        matching: find.text('$count'),
      );
    }

    expect(findCount(0), findsOneWidget);
    expect(findCount(1), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(findCount(0), findsNothing);
    expect(findCount(1), findsOneWidget);
    expect(findCount(2), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(findCount(1), findsNothing);
    expect(findCount(2), findsOneWidget);
    expect(findCount(3), findsNothing);
  });
}
