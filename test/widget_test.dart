import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:river_navigator/src/app/app.dart';
import 'package:river_navigator/src/pages/pages.dart';

import '../test/src/widgets/counter_scaffold_test.dart';
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
    final flowPage = find.byType(CounterFlow);
    return flowPage;
  }
}

extension Page2NavigatorTester on WidgetTester {
  Future<Finder> pushPage3(Finder page2) async {
    final page3 = find.byType(Page3);
    expect(page3, findsNothing);

    final pushPage3Button = page2.descendantByKey(const Key('push_page3'));
    expect(pushPage3Button, findsOneWidget);
    await tap(pushPage3Button);
    await pumpAndSettle(const Duration(milliseconds: 400));

    expect(page2, findsNothing);
    expect(page3, findsOneWidget);
    return page3;
  }

  Future<Finder> replaceWithPage3(Finder page2) async {
    final page3 = find.byType(Page3);
    expect(page3, findsNothing);

    final replaceWithPage3Button = page2.descendantByKey(
      const Key('replace_with_page3'),
    );
    expect(replaceWithPage3Button, findsOneWidget);
    await tap(replaceWithPage3Button);
    await pumpAndSettle(const Duration(milliseconds: 400));

    expect(page2, findsNothing);
    expect(page3, findsOneWidget);
    return page3;
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

      final flowPage = find.byType(CounterFlow);
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
  });

  group('Page3 pushed from Page2', () {
    testWidgets('Page3 and Page2 must keep the same counter',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2.findCounter(0), findsOneWidget);
      final page3 = await tester.pushPage3(page2);
      expect(page3.findCounter(0), findsOneWidget);
      await tester.tapBackButton(page3);

      await tester.incrementCounter(page2, times: 10);
      await tester.pushPage3(page2);
      expect(page3.findCounter(10), findsOneWidget);

      await tester.incrementCounter(page3, times: 2);

      expect(page3.findCounter(12), findsOneWidget);
      await tester.tapBackButton(page3);
      expect(page2.findCounter(12), findsOneWidget);
    });
  });

  group('Page3 replaces Page2', () {
    testWidgets('Pop on Page3 must go to Page1', (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2.findCounter(0), findsOneWidget);
      await tester.incrementCounter(page2, times: 10);

      final page3 = await tester.replaceWithPage3(page2);
      expect(page3.findCounter(10), findsOneWidget);

      final page1 = find.byType(Page1);
      expect(page1, findsNothing);

      await tester.tapBackButton(page3);
      expect(page1, findsOneWidget);
    });

    testWidgets('Tap on pop button on Page3 must go to Page1',
        (WidgetTester tester) async {
      final flowPage = await tester.fromPage1ToFlowPage(counter: 5);
      final page2 = flowPage.descendantByType(Page2);
      expect(page2.findCounter(0), findsOneWidget);
      await tester.incrementCounter(page2, times: 10);

      final page3 = await tester.replaceWithPage3(page2);
      expect(page3.findCounter(10), findsOneWidget);

      final page1 = find.byType(Page1);
      expect(page1, findsNothing);

      await tester.tapBackButton(page3, type: ElevatedButton);

      expect(page1, findsOneWidget);
      expect(flowPage, findsNothing);
      expect(page2, findsNothing);
      expect(page3, findsNothing);
    });
  });
}
