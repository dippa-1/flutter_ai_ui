import 'package:flutter/material.dart';

class DeviceDiagnosisPage extends StatelessWidget {
  const DeviceDiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Diagnosis'),
      ),
      body: const Center(
        child: Text(
          'This is the device diagnosis page',
        ),
      ),
    );
  }
}