import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_navigator/src/page1.dart';

void main() {
  runApp(const ProviderScope(child: RiverNavigatorApp()));
}

class RiverNavigatorApp extends StatelessWidget {
  const RiverNavigatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page1(),
    );
  }
}
