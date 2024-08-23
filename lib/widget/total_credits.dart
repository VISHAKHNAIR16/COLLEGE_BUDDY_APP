import 'package:flutter/material.dart';

class TotalCredits extends StatelessWidget {
  final ValueChanged<int> onChanged;

  const TotalCredits({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Total Credits: '),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Safely parse the value and handle the case where it might be null
              final parsedValue = int.tryParse(value);
              onChanged(
                  parsedValue ?? 0); // Ensure that the callback receives an int
            },
          ),
        ),
      ],
    );
  }
}
