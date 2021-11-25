import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/widgets/widgets.dart';

class FlowProviderScope extends StatelessWidget {
  const FlowProviderScope({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [counterProvider],
      child: child,
    );
  }
}
