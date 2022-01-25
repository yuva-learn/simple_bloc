import 'package:flutter/material.dart';
import 'package:my_bloc/simple_bloc_counter/simple_counter_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SimpleCounterScreen(),
    );
  }
}
