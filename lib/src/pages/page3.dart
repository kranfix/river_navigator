import 'package:flutter/material.dart';
import 'package:river_navigator/src/pages/counter_flow.dart';
import 'package:river_navigator/src/widgets/widgets.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  static void navigate(BuildContext context) {
    return CounterFlow.of(context).push(
      const MaterialPage(child: Page3()),
    );
  }

  static void replace(BuildContext context) {
    return CounterFlow.of(context).replaceWith(
      const MaterialPage(child: Page3()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Page 3',
      children: [
        ElevatedButton(
          onPressed: () => CounterFlow.of(context).pop(),
          child: Text('pop'),
        ),
      ],
    );
  }
}
