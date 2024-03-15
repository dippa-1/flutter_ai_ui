import 'package:flutter/material.dart';

class EnrollDevicePage extends StatelessWidget {
  const EnrollDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enroll Device'),
      ),
      body: const Center(
        child: Text(
          'This is the enroll device page',
        ),
      ),
    );
  }
}