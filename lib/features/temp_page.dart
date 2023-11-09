import 'package:flutter/material.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  static MaterialPageRoute<TempPage> route() => MaterialPageRoute<TempPage>(
        builder: (context) => const TempPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temp Page')),
      body: const Center(child: Text('Hello world')),
    );
  }
}
