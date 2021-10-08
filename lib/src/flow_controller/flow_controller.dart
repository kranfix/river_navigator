import 'package:flutter/material.dart';
import 'package:river_navigator/src/pages/counter_flow/flow_provider_scope.dart';

mixin FlowController {
  void pop();
  void push(Page<dynamic> page);
  void replaceWith(Page<dynamic> page);
}

class FlowScope extends StatefulWidget {
  const FlowScope({Key? key, required this.initialStack}) : super(key: key);

  final List<Page<dynamic>> initialStack;

  @override
  _FlowScopeState createState() => _FlowScopeState();

  static FlowController of(BuildContext context) {
    return context.findAncestorStateOfType<_FlowScopeState>()!;
  }
}

class _FlowScopeState extends State<FlowScope> with FlowController {
  late final pages = <Page<dynamic>>[...widget.initialStack];

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
