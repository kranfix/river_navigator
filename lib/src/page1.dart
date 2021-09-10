import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/flow_page.dart';

final counterProvider = StateProvider((ref) => 0);

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var showProvider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Column(
          children: [
            if (showProvider)
              Consumer(
                builder: (_, ref, __) {
                  final counter = ref.watch(counterProvider).state;
                  return Text('$counter');
                },
              )
            else
              Text('No provider'),
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
            if (showProvider) {
              ref.read(counterProvider).state++;
            } else {
              setState(() => showProvider = true);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
