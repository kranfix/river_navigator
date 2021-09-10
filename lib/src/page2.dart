import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/page1.dart';
import 'package:river_navigator/src/page3.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2 '),
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
              onPressed: () => Page3.navigate(context),
              child: Text('Push Page3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Page3.replace(context),
              child: Text('Push Replacement Page3'),
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
