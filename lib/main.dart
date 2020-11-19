import 'package:flutter/material.dart';
import 'package:tdd_demo/startup_name_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        home: StartupNameList(
          entries: ['Name 1', 'Name 2'],
        ));
  }
}
