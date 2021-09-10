import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:river_navigator/main.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/page1.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(const ProviderScope(child: RiverNavigatorApp()));
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

    testWidgets('Go to Page3, pop and pop must go to Page1',
        (WidgetTester tester) async {
      await tester.pumpApp();

      final goToFlowButton = find.byType(ElevatedButton);

      await tester.tap(goToFlowButton);
    }, skip: true);

    testWidgets('Replace to Page3 and pop must go to Page1',
        (WidgetTester tester) async {
      tester.pumpApp();
    }, skip: true);
  });
}
