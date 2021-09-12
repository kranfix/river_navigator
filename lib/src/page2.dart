import 'package:flutter/material.dart';
import 'package:river_navigator/src/page3.dart';
import 'package:river_navigator/src/widgets/counter_scaffold.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();

  static Future<void> navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Page2(),
      ),
    );
  }
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return CounterScaffold(
      title: 'Page 2 ',
      children: [
        ElevatedButton(
          key: const Key('push_page3'),
          onPressed: () => Page3.navigate(context),
          child: Text('Push Page3'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          key: const Key('replace_with_page3'),
          onPressed: () => Page3.replace(context),
          child: Text('Push Replacement Page3'),
        ),
      ],
    );
  }
}
