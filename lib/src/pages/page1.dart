import 'package:flutter/material.dart';
import 'package:river_navigator/src/pages/counter_flow.dart';
import 'package:river_navigator/src/widgets/widgets.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Page 1',
      children: [
        ElevatedButton(
          onPressed: () => CounterFlow.navigate(context),
          child: Text('Go to page 2 in CounterFlow'),
        ),
      ],
    );
  }
}
