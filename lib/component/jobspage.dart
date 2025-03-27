import 'package:flutter/material.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Jobs Page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}