import 'package:flutter/material.dart';

class LockingPage extends StatelessWidget {
  const LockingPage({super.key});

  static MaterialPageRoute<LockingPage> route() =>
      MaterialPageRoute<LockingPage>(
        builder: (context) => const LockingPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locking Page')),
      body: const Center(child: Text('Hello world')),
    );
  }
}
