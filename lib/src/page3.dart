import 'package:flutter/material.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/widgets/counter_scaffold.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  static void navigate(BuildContext context) {
    return FlowPage.of(context).push(
      const MaterialPage(child: Page3()),
    );
  }

  static void replace(BuildContext context) {
    return FlowPage.of(context).replaceWith(
      const MaterialPage(child: Page3()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Page 3',
      children: [
        ElevatedButton(
          onPressed: () => FlowPage.of(context).pop(),
          child: Text('pop'),
        ),
      ],
    );
  }
}
