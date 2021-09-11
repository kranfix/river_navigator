import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);

class CounterScaffold extends StatelessWidget {
  const CounterScaffold({Key? key, required this.title, this.children})
      : super(key: key);

  final String title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Consumer(
              builder: (_, ref, __) {
                final counter = ref.watch(counterProvider).state;
                return Text('$counter');
              },
            ),
            const SizedBox(height: 20),
            ...?children,
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
