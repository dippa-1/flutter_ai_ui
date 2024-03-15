import 'package:flutter/material.dart';

class StatusOverviewPage extends StatelessWidget {
  const StatusOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Overview'),
      ),
      body: const Center(
        child: Text(
          'This is the status overview page',
        ),
      ),
    );
  }
}