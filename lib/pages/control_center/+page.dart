import 'package:flutter/material.dart';

class ControlCenterPage extends StatelessWidget {
  const ControlCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Center'),
      ),
      body: const Center(
        child: Text(
          'This is the control center page',
        ),
      ),
    );
  }
}