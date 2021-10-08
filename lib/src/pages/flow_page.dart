import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/pages/page2.dart';
import 'package:river_navigator/src/widgets/widgets.dart';

class FlowPage extends StatefulWidget {
  const FlowPage({Key? key}) : super(key: key);

  @override
  _FlowPageState createState() => _FlowPageState();

  static Future<void> navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlowPage(),
      ),
    );
  }

  static FlowController of(BuildContext context) {
    return context.findAncestorStateOfType<_FlowPageState>()!;
  }
}

mixin FlowController {
  void pop();
  void push(Page<dynamic> page);
  void replaceWith(Page<dynamic> page);
}

class _FlowPageState extends State<FlowPage> with FlowController {
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

class FlowProviderScope extends ConsumerStatefulWidget {
  const FlowProviderScope({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _FlowProviderScopeState createState() => _FlowProviderScopeState();
}

class _FlowProviderScopeState extends ConsumerState<FlowProviderScope> {
  final counterValue = StateController(0);

  @override
  void dispose() {
    super.dispose();
    counterValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        counterProvider.overrideWithValue(counterValue),
      ],
      child: widget.child,
    );
  }
}
