import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:river_navigator/main.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/page1.dart';
import 'package:river_navigator/src/page2.dart';
import 'src/widgets/counter_scaffold_test.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(const ProviderScope(child: RiverNavigatorApp()));
  }

  Future<Finder> fromPage1ToFlowPage({int counter = 0}) async {
    await pumpApp();
    final page1 = find.byType(Page1);
    final goToFlowButton = find.descendant(
      of: page1,
      matching: find.byType(ElevatedButton),
    );

    if (counter > 0) {
      await incrementCounter(page1, times: counter);
    }

    await tap(goToFlowButton);
    await pumpAndSettle(const Duration(milliseconds: 400));
    final flowPage = find.byType(FlowPage);
    return flowPage;
  }
}

void main() {
  group('From Page1 to Page2', () {
    testWidgets('Page1 to FlowPage', (WidgetTester tester) async {
      await tester.pumpApp();

      final page1 = find.byType(Page1);
      expect(find.byType(Page1), findsOneWidget);

      final goToFlowButton = find.descendant(
        of: page1,
        matching: find.byType(ElevatedButton),
      );
      expect(goToFlowButton, findsOneWidget);

      await tester.tap(goToFlowButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      final flowPage = find.byType(FlowPage);
      expect(flowPage, findsOneWidget);
    });

    testWidgets('Go to Page2 and pop must go to Page1',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);

      expect(flowPage, findsOneWidget);

      final page2 = find.descendant(
        of: flowPage,
        matching: find.byType(Page2),
      );
      expect(page2, findsOneWidget);

      expect(page2.findCounter(0), findsOneWidget);

      await tester.incrementCounter(page2, times: 10);
      expect(page2.findCounter(10), findsOneWidget);

      final popButton = find.descendant(
        of: page2,
        matching: find.byType(BackButton),
      );
      expect(popButton, findsOneWidget);
      await tester.tap(popButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(find.byType(Page1), findsOneWidget);
    });

    testWidgets('Go to Page3, pop and pop must go to Page1',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);

      expect(flowPage, findsOneWidget);

      final page2 = find.descendant(
        of: flowPage,
        matching: find.byType(Page2),
      );
      expect(page2, findsOneWidget);

      expect(page2.findCounter(0), findsOneWidget);

      //await tester.tap(goToFlowButton);
    });

    testWidgets('Replace to Page3 and pop must go to Page1',
        (WidgetTester tester) async {
      tester.pumpApp();
    }, skip: true);
  });
}
