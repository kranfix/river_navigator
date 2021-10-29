import 'package:flutter/material.dart';
import 'package:river_navigator/src/flow_controller/flow_controller.dart';
import 'package:river_navigator/src/pages/counter_flow/flow_provider_scope.dart';
import 'package:river_navigator/src/pages/page2.dart';

class CounterFlow extends StatelessWidget {
  const CounterFlow({Key? key}) : super(key: key);

  static Future<void> navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CounterFlow(),
      ),
    );
  }

  static FlowController of(BuildContext context) {
    return FlowScope.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return FlowProviderScope(
      child: FlowScope(
        initialStack: [
          const MaterialPage(child: Page2()),
        ],
      ),
    );
  }
}
