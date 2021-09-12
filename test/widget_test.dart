import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:river_navigator/main.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/page1.dart';
import 'package:river_navigator/src/page2.dart';
import 'src/widgets/counter_scaffold_test.dart';
import 'helpers/helpers.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(const ProviderScope(child: RiverNavigatorApp()));
  }

  Future<Finder> fromPage1ToFlowPage({int counter = 0}) async {
    await pumpApp();
    final page1 = find.byType(Page1);
    final goToFlowButton = page1.descendantByType(ElevatedButton);

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

      final goToFlowButton = page1.descendantByType(ElevatedButton);
      expect(goToFlowButton, findsOneWidget);

      await tester.tap(goToFlowButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      final flowPage = find.byType(FlowPage);
      expect(flowPage, findsOneWidget);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2, findsOneWidget);
      expect(find.byType(Page1), findsNothing);
    });

    testWidgets('Go to Page2 and pop must go to Page1',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage();
      expect(flowPage, findsOneWidget);

      final page2 = flowPage.descendantByType(Page2);
      await tester.tapBackButton(page2);

      expect(find.byType(Page1), findsOneWidget);
      expect(page2, findsNothing);
    });

    testWidgets(
        'Go to Page2, increments and pop must go to Page1 and keep the counter',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);

      expect(page2.findCounter(0), findsOneWidget);
      await tester.incrementCounter(page2, times: 10);
      expect(page2.findCounter(10), findsOneWidget);

      final popButton = page2.descendantByType(BackButton);
      expect(popButton, findsOneWidget);
      await tester.tap(popButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      expect(page2, findsNothing);

      final page1 = find.byType(Page1);
      expect(page1, findsOneWidget);
      expect(page1.findCounter(5), findsOneWidget);
    });

    testWidgets('Page2 is reset on pop and pushing it again',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      await tester.incrementCounter(page2, times: 10);
      expect(page2.findCounter(10), findsOneWidget);

      await tester.tapBackButton(page2);

      final page1 = find.byType(Page1);
      expect(page1, findsOneWidget);
      expect(page1.findCounter(5), findsOneWidget);

      await tester.fromPage1ToFlowPage(counter: 5);

      expect(page2.findCounter(0), findsOneWidget);
    });

    testWidgets('Push Page3 from Page2 must keep the same counter',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2.findCounter(0), findsOneWidget);
      await tester.incrementCounter(page2, times: 10);
    }, skip: true);

    testWidgets('Go to Page3, pop and pop must go to Page1',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2.findCounter(0), findsOneWidget);
      await tester.incrementCounter(page2, times: 10);
    }, skip: true);

    testWidgets('Replace to Page3 and pop must go to Page1',
        (WidgetTester tester) async {
      tester.pumpApp();
    }, skip: true);
  });
}
