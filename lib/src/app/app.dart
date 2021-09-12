import 'package:flutter/material.dart';
import 'package:river_navigator/src/pages/pages.dart';

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
