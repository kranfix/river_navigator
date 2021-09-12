import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension DecendantFinder on Finder {
  Finder descendantByType(Type type) {
    return find.descendant(
      of: this,
      matching: find.byType(type),
    );
  }

  Finder descendantByKey(Key key) {
    return find.descendant(
      of: this,
      matching: find.byKey(key),
    );
  }
}

extension AppTester on WidgetTester {
  Future<void> tapBackButton(Finder page, {Type type = BackButton}) async {
    final popButton = page.descendantByType(type);
    expect(popButton, findsOneWidget);
    await tap(popButton);
    await pumpAndSettle(const Duration(milliseconds: 400));
  }
}
