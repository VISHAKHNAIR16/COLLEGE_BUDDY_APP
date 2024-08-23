import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Submit'),
    );
  }
}
