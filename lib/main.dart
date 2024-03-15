import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_ui/pages/charts/+page.dart';
import 'package:flutter_ai_ui/pages/control_center/+page.dart';
import 'package:flutter_ai_ui/pages/device_diagnosis/+page.dart';
import 'package:flutter_ai_ui/pages/enroll_device/+page.dart';
import 'package:flutter_ai_ui/pages/status_overview/+page.dart';

void main() {
  OpenAI.apiKey = ''; // your OpenAI API key
  runApp(const MyApp());
}

enum Page {
  statusOverview,
  enrollDevice,
  controlCenter,
  charts,
  deviceDiagnosis;

  Widget get page {
    switch (this) {
      case Page.statusOverview:
        return const StatusOverviewPage();
      case Page.enrollDevice:
        return const EnrollDevicePage();
      case Page.controlCenter:
        return const ControlCenterPage();
      case Page.charts:
        return const ChartsPage();
      case Page.deviceDiagnosis:
        return const DeviceDiagnosisPage();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _actionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AI based navigation'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _actionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'How can I help you?',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Do it!'),
                  onPressed: () => _performAction(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _performAction(BuildContext context) {
    final action = _actionController.text;
    if (action.isEmpty) {
      return;
    }

    OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(action),
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
      tools: [
        OpenAIToolModel(
          type: "function",
          function: OpenAIFunctionModel.withParameters(
            name: "navigate",
            parameters: [
              OpenAIFunctionProperty.primitive(
                name: "page",
                type: "string",
                enumValues: Page.values.map((e) => e.toString()).toList(),
                description: "The page to navigate to in the app",
              ),
            ],
          ),
        ),
      ],
    ).then((res) {
      final function = res.choices.first.message.toolCalls?.first.function;
      final name = function?.name;
      final functionArguments = function?.arguments;
      final decodedArgs = jsonDecode(functionArguments);

      if (name != 'navigate') {
        return;
      }

      final page = Page.values.firstWhere(
        (e) => e.toString() == decodedArgs['page'],
      );

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page.page),
      );
    });
  }
}
