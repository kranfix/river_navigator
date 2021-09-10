import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/flow_page.dart';
import 'package:river_navigator/src/page1.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();

  static void navigate(BuildContext context) {
    return FlowPage.of(context).push(
      MaterialPage(
        child: Page3(),
      ),
    );
  }

  static void replace(BuildContext context) {
    return FlowPage.of(context).replaceWith(
      MaterialPage(
        child: Page3(),
      ),
    );
  }
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: (_, ref, __) {
                final counter = ref.watch(counterProvider).state;
                return Text('$counter');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => FlowPage.of(context).pop(),
              child: Text('pop'),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (_, ref, __) => FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider).state++;
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
