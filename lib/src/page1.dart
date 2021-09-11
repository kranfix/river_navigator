import 'package:flutter/material.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/widgets/counter_scaffold.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Page 1',
      children: [
        ElevatedButton(
          onPressed: () => FlowPage.navigate(context),
          child: Text('Go to page 2 in FlowPage'),
        ),
      ],
    );
  }
}
