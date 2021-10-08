import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/widgets/widgets.dart';

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
