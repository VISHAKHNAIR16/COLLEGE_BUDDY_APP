import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double gpa;

  const SubmitButtonWidget(
      {super.key, required this.onPressed, required this.gpa});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_right_alt_outlined),
          label: const Text('Submit'),
        ),
        const SizedBox(height: 20),
        Text(
          'Your GPA is: ${gpa.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
