import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/flow_page.dart';

final counterProvider = StateProvider((ref) => 0);

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
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
              onPressed: () => FlowPage.navigate(context),
              child: Text('Go to page 2'),
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
