import 'package:flutter/material.dart';

/// Flutter code sample for [Stepper].

// Relevant Properties:
// steps: list of steps
// onStepContinue: function when continue is clicked
// onStepCancel: function when cancel is clicked
// if defining a list of steps define it in build method and also the functions youll use in Step widget's content property
// Step Widget property: #title: Text Widget to show title # content: contnet to be showed

class StepperExampleApp extends StatelessWidget {
  const StepperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Stepper Sample')),
        body: const Center(child: StepperExample()),
      ),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index --;
          });
        }
      },
      onStepContinue: () {
        if (_index < 2) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 1'),
          ),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
