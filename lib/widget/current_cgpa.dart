import 'package:flutter/material.dart';

class CurrentCGPA extends StatelessWidget {
  final ValueChanged<double> onChanged;

  const CurrentCGPA({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Current CGPA: '),
        Expanded(
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              border:
                  OutlineInputBorder(), // Optional: adds a border to the TextField
              hintText: 'Enter CGPA',
            ),
            onChanged: (value) {
              // Parse the input value to a double
              double parsedValue = double.tryParse(value) ?? 0.0;
              onChanged(parsedValue);
            },
          ),
        ),
      ],
    );
  }
}
