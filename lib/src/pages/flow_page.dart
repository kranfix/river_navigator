import 'package:flutter/material.dart';
import 'package:river_navigator/src/pages/counter_flow/flow_provider_scope.dart';
import 'package:river_navigator/src/pages/page2.dart';

class CounterFlow extends StatefulWidget {
  const CounterFlow({Key? key}) : super(key: key);

  @override
  _CounterFlowState createState() => _CounterFlowState();

  static Future<void> navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CounterFlow(),
      ),
    );
  }

  static FlowController of(BuildContext context) {
    return context.findAncestorStateOfType<_CounterFlowState>()!;
  }
}

mixin FlowController {
  void pop();
  void push(Page<dynamic> page);
  void replaceWith(Page<dynamic> page);
}

class _CounterFlowState extends State<CounterFlow> with FlowController {
  final pages = <Page<dynamic>>[
    const MaterialPage(child: Page2()),
  ];

  @override
  void pop() {
    if (pages.length == 1) {
      Navigator.of(context).pop();
    } else {
      setState(() => pages.removeLast());
    }
  }

  @override
  void push(Page<dynamic> page) {
    setState(() => pages.add(page));
  }

  @override
  void replaceWith(Page<dynamic> page) {
    setState(() => pages.last = page);
  }

  @override
  Widget build(BuildContext context) {
    return FlowProviderScope(
      child: Navigator(
        pages: [
          const MaterialPage(child: Offstage()),
          ...pages,
        ],
        onPopPage: (route, result) {
          pop();
          return route.didPop(result);
        },
      ),
    );
  }
}
